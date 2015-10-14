module Lazybird
  module Tasks
    class RetweetRandomTask < Lazybird::Tasks::Task
      def run
        @twitter_client.retweet_random_friend
      end
    end
  end
end