require 'sequel'
require 'lazybird/tasks/task'
require 'lazybird/utils'
require 'lazybird/config'
module Lazybird
  module Db
    extend self

    #TODO: refactor this. This is a quick & dirty way to create the DB
    def self.init
      db.transaction do
        db.create_table :config do
          primary_key :id
          String :name, :unique => true, :null => false
          String :consumer_key, :null => false
          String :consumer_secret, :null => false
          String :access_token, :null => false
          String :access_token_secret, :null => false
        end

        db.create_table :tweets do
          primary_key :id
          String :text, :unique => true, :null => false
          DateTime :created_at
        end

        db.create_table :tasks do
          primary_key :id
          String :command, :unique => true, :null => false
          String :options
          DateTime :created_at
        end
      end
    end

    def save_tweet!(text:)
      db[:tweets].insert(text: text, created_at: DateTime.now)
    end

    # TODO: Ideally we should have different configs, perhaps per twitter user
    # for now, let's just delete every time we save a new one.
    def save_config!(config)
      db[:config].delete
      db[:config].insert(config.merge(name: 'default'))
    end

    def config
      db[:config].first
    end

    def save_task!(task)
      task_hash = {command: task.command,
                   created_at: DateTime.now}
      task_hash.merge!(options: task.opts) if !task.opts.empty?
      db[:tasks].insert(Lazybird::Utils::Hash.compact(task_hash))
    end

    def rem_task!(task_command)
      db[:tasks].where('command = ?', task_command).delete
    end

    def list_tasks
      db[:tasks].select(:command)
    end

    def tasks
      db[:tasks].all.map do |task|
        found = Lazybird::Utils::Hash.find_by_key(Lazybird::Config.tasks, task[:command])
        unless found.empty?
          task_found(task[:command], found).new(command: task[:command],
                                                options: found[:options])
        end
      end
    end

    def task_found(task_name, found)
      Object.const_get(found[task_name]['class'])
    end

    def db
      @_db ||= Sequel.amalgalite(Lazybird::Config.db_file)
    end
  end
end