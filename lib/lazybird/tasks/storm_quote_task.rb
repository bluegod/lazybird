require 'lazybird/tasks/quote'

module Lazybird
  module Tasks
    class StormQuoteTask < Lazybird::Tasks::Task
      def run
        quote = Lazybird::Tasks::Quote.new(url: 'http://quotes.stormconsultancy.co.uk/random.json')
        @twitter_client.tweet(message: quote.random_storm_quote)
      end
    end
  end
end