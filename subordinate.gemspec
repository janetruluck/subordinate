# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'subordinate/version'

Gem::Specification.new do |gem|
  gem.name          = "subordinate"
  gem.version       = Subordinate::VERSION
  gem.authors       = ["Jason Truluck"]
  gem.email         = ["jason.truluck@gmail.com"]
  gem.description   = %q{Jenkins API wrapper}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/jasontruluck/subordinate"
  gem.license       = "MIT"

  # gem.add_dependency "faraday"
  gem.add_dependency "faraday", "~> 0.8.0"
  gem.add_dependency "faraday_middleware", "~> 0.9.0"
  gem.add_dependency "hashie", "~> 2.0.0"
  gem.add_dependency 'multi_json', "~> 1.8.0"
  gem.add_development_dependency "rspec", "~> 2.14.0"
  gem.add_development_dependency "rake", "~> 10.1.0"
  gem.add_development_dependency "webmock", "~> 1.13.0"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "simplecov", "~> 0.7.0"
  gem.add_development_dependency "coveralls", "~> 0.7.0"
  gem.add_development_dependency "yard", "~> 0.8.0.0"
  gem.add_development_dependency "redcarpet", "~> 3.0.0"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
