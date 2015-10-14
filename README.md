# Lazybird (Beta)

[![Gem Version](https://img.shields.io/badge/lazybird-v0.1.0beta-orange.svg)][gem]

[gem]: https://rubygems.org/gems/lazybird

Twitter for busy people.

## Installation

Register at https://apps.twitter.com/app/new

Example: 

![](http://i.imgsafe.org/fbf19e8.png)

Then click on keys and access tokens and generate an access token. You will need this for the setup.


Install lazybird running:

    $ gem install lazybird

## Setup

Once lazybird is installed you can run it with:

`lazybird` 

or

`bundle exec lazybird`

The CLI should appear:

![](http://i.imgsafe.org/bdeff99.png)


Typically you want to setup the database first running `setup`

And run config to enter your twitter settings: `config consumer_key consumer_secret access_token access_token_secret`

## Usage

Run it with `lazybird` - you would need to keep the app running as long as you want to tweet automatically.

Lazybird contains (at the moment) only two tasks that run at a certain configured time:


_retweet_random_: Retweets a random tweet (latest) from a random friend

_tweet_storm_: Tweets a random quote from the Storm API http://quotes.stormconsultancy.co.uk


Add them both to your list of tasks (this will store them in an internal DB to resume later)

 `add retweet_random`
 
 `add tweet_storm`
 
 Then you want to either randomly tweet something now with `run now` or schedule it to tweet every N minutes/hours/day:s `run 2h` or `run 30m` for example.
 
 You will need to keep the command line open and you should see an update everytime something random gets tweeted.
 
 Lazybird stores a DB/config file at ~/.twitter.db - make sure it's safe.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bluegod/lazybird.

## License

GPL v2
