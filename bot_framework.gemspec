# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bot_framework/version'

Gem::Specification.new do |spec|
  spec.name          = 'bot_framework'
  spec.version       = BotFramework::VERSION
  spec.authors       = ['Aboobacker MK']
  spec.email         = ['aboobackervyd@gmail.com']

  spec.summary       = 'Ruby client for microsoft botframework .'
  spec.description   = 'Unofficial ruby client for microsoft botframework'
  spec.homepage      = 'https://github.com/tachyons/bot-framework-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'

  spec.add_dependency 'oauth2'
  spec.add_dependency 'jwt'
  spec.add_dependency 'httparty'
  spec.add_dependency 'rack'
  spec.add_dependency 'timers'
  spec.add_dependency 'rb-readline'
  spec.add_dependency 'chronic'
  spec.add_dependency 'chronic_duration'
end
