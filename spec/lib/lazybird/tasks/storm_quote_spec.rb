require 'spec_helper'
require 'lazybird/tasks/quote'

# Smoke test - will actually call the API URL

describe 'retrieves a random quote using the API' do

  let(:storm_url) { 'http://quotes.stormconsultancy.co.uk/random.json' }
  let(:quote) { Lazybird::Tasks::Quote.new(url: storm_url) }
  let(:retry_attempts) { 3 }

  it 'displays a random quote with less than 141 chars' do
    expect(quote.random_storm_quote.length).to be < 141
  end

  it 'displays a random quote after "retry_attempts" attempts' do
    expect {
      (retry_attempts + 1).times {quote.random_storm_quote}
    }.not_to raise_exception
  end

end