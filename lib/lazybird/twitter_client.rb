require 'lazybird/db'

module Lazybird
  module TwitterClient
    extend self

    def retweet_random_friend
      tweet = random_friend_tweet
      message = tweet.text
      duplicate_tweet_check(message)
      client.retweet tweet
      message
    rescue Twitter::Error::Forbidden, Sequel::UniqueConstraintViolation
      duplicated_tweet_warning
    end

    def tweet(message:)
      duplicate_tweet_check(message)
      client.update message
      message
    rescue Twitter::Error::Forbidden, Sequel::UniqueConstraintViolation
      duplicated_tweet_warning
    end

    private

    def random_friend_id
      client.friends.to_a.sample.id
    end

    def random_friend_tweet
      client.user_timeline(random_friend_id, {count: 1}).first
    end

    def client
      @_client ||= Lazybird::Config.client
    end

    def duplicated_tweet_warning
      puts 'Same tweet found! Ignoring this run...'
      nil
    end

    def duplicate_tweet_check(message)
      Lazybird::Db.save_tweet!(text: message)
    end
  end
end