require 'json'
require 'open-uri'

module Lazybird
  module Tasks
    class Quote
      def initialize(url:, retry_attempts: 3)
        @url = url
        @retry_attempts = retry_attempts
        @retry_count = 0
      end

      # TODO create a generic way to call diff apis (this should be on its own subclass)
      def random_storm_quote
        raise Lazybird::QuoteMaxRetriesException if @retry_count > @retry_attempts
        quote = fetch_json(@url)['quote']
        quote_check(quote) { random_storm_quote }
      end

      def quote_check(quote)
        if quote.length > 140
          @retry_count += 1
          yield
        else
          @retry_count = 0
          quote
        end
      end

      private

      def fetch_json(json_url)
        JSON.load(open(json_url))
      end
    end

    class QuoteMaxRetriesException < StandardError;
    end
  end
end