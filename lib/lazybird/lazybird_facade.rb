require 'lazybird/config'
require 'lazybird/db'
require 'lazybird/utils'
require 'lazybird/tasks/storm_quote_task'
require 'lazybird/tasks/retweet_random_task'
require 'lazybird/tasks/task_scheduler'

module Lazybird
  #TODO: split this file
  class LazybirdFacade

    attr_reader :tasks

    def initialize
      @current_tasks = Set.new
      @tasks = Lazybird::Config.tasks
    end

    def add_task(task_name)
      # TODO refactor this method
      found = Lazybird::Utils::Hash.find_by_key(@tasks, task_name)
      if found
        task = Object.const_get(found[task_name]['class']).new(command: task_name)
        begin
          Lazybird::Db.save_task!(task)
        rescue Sequel::UniqueConstraintViolation
          puts 'Task added already'.light_red
        end
        @current_tasks << task
      end
    end

    def rem_task(task_name)
      Lazybird::Db.rem_task!(task_name)
      @current_tasks.delete_if { |t| t.command == task_name }
    end

    def current_tasks
      @current_tasks.map { |t| t.command }
    end

    def load_default_tasks
      @current_tasks.merge(Lazybird::Db.tasks)
    end

    def init
      Lazybird::Db.init
    end

    def config(params)
      config = Lazybird::Utils::Hash.array_to_hash([:consumer_key,
                                                    :consumer_secret,
                                                    :access_token,
                                                    :access_token_secret], params)
      Lazybird::Db.save_config! config
    end

    def run_tasks(params, &block)
      if params.first == 'now'
        run_random_task
      else
        Lazybird::Tasks::TaskScheduler.schedule(frequency: params.first) do
          run_random_task(&block)
        end
      end
    end

    def run_info
      Lazybird::Tasks::TaskScheduler.job_info
    end

    private

    def run_random_task(&block)
      puts 'Twitting something random...'.yellow
      text = @current_tasks.to_a.sample.run
      if text.nil?
        puts "Sorry! We couldn't tweet :(".light_red
      else
        puts "<<#{text.magenta}>>"
      end
      yield if block
      text
    end
  end
end