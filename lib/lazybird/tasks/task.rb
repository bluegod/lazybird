require 'lazybird/twitter_client'

module Lazybird
  module Tasks
    class Task
      attr_reader :command, :opts

      def initialize(command:, twitter_client: Lazybird::TwitterClient, **opts)
        # TODO define command on subclass
        @command = command
        @opts = opts
        @twitter_client = twitter_client
      end

      def run
        raise NotImplementedError
      end
    end
  end
end
