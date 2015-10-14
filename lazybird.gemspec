# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lazybird/version'

Gem::Specification.new do |spec|
  spec.name          = 'lazybird'
  spec.version       = Lazybird::VERSION
  spec.authors       = ['James Lopez']
  spec.email         = ['james@jameslopez.es']
  spec.license       = 'GPL-2.0'

  spec.summary       = %q{Twitter for lazy people. Automatically tweets/retweets random stuff. }
  spec.description   = %q{Provides a command line interface to interact with twitter and automatically tweets/retweets some predefined (or API based tweets) at a specified frequency. }
  spec.homepage      = "https://github.com/bluegod/lazybird"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ['lazybird']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
  spec.add_dependency 'twitter', '~> 5.15'
  spec.add_dependency 'rufus-scheduler', '~> 3.1'
  spec.add_dependency 'amalgalite', '~> 1.4'
  spec.add_dependency 'sequel', '~> 4.27'
  spec.add_dependency 'colorize', '~> 0.7'
end
