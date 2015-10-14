require 'twitter'
require 'yaml'
require 'lazybird/db'

module Lazybird
  module Config
    extend self

    def client
      @_client ||= Twitter::REST::Client.new do |config|
        config.consumer_key = db_config[:consumer_key]
        config.consumer_secret = db_config[:consumer_secret]
        config.access_token = db_config[:access_token]
        config.access_token_secret = db_config[:access_token_secret]
      end
    end

    def tasks
      @_tasks ||= YAML::load_file('./lib/config/tasks.yml')
    end

    def db_file
      "#{Dir.home}/.twitter.db"
    end

    def db_file_exists?
      File.file? db_file
    end

    private

    def db_config
      #TODO: nice to have - this should go to the DB if a new config is saved.
      @_config ||= Lazybird::Db.config
    end
  end
end