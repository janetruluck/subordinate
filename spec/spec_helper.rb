require 'rubygems'
require 'coveralls'
Coveralls.wear!

ENV["RAILS_ENV"] ||= 'test'

if ENV['RAILS_ENV'] == 'test'
  require 'simplecov'
  SimpleCov.start 'rails'
  class SimpleCov::Formatter::QualityFormatter
    def format(result)
      SimpleCov::Formatter::HTMLFormatter.new.format(result)
      File.open("coverage/covered_percent", "w") do |f|
        f.puts result.source_files.covered_percent.to_f
      end
    end
  end
  SimpleCov.formatter = SimpleCov::Formatter::QualityFormatter
end

require 'subordinate'
require "webmock/rspec"
require "mocha/api"

Dir[File.expand_path("spec/support/**/*.rb", __FILE__)].each {|f| require f}

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.order                                           = "random"
end

def stub_jenkins(http_method = :any, endpoint = "/", status = 200, content_type = "application/json", response)
  stub_request(http_method, "http://someusername:sometoken@jenkins.example.com:8080#{endpoint}").
  to_return(:status => status, 
    :body => File.read(File.expand_path("../support/mocks/#{response}", __FILE__)),
    :headers =>{'Accept' => content_type, 'Content-type' => content_type})
end
