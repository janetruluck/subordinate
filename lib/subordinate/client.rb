# Client Module
require "subordinate/authentication"
require "subordinate/connection"
require "subordinate/request"
Dir[File.expand_path("../client/*.rb", __FILE__)].each {|f| require f }

module Subordinate
  class Client
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options = {})
      options = Subordinate.options.merge(options)

      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    # Builds the api endpoint to reach the Jenkins Server
    #
    # @return [String] Endpoint - the api endpoint to the server
    def api_endpoint
      build_endpoint
    end

    include Subordinate::Authentication
    include Subordinate::Connection
    include Subordinate::Request

    include Subordinate::Client::Job
    include Subordinate::Client::System
    include Subordinate::Client::Build
    include Subordinate::Client::Queue
    include Subordinate::Client::Load
    include Subordinate::Client::People
    include Subordinate::Client::View
    include Subordinate::Client::Executor

    private
    def build_endpoint
      endpoint = ssl ? "https://" : "http://"
      endpoint << "#{self.subdomain}."              if self.subdomain
      endpoint << "#{self.domain}"                  if self.domain
      endpoint << ":#{self.port}"                   if self.port
      endpoint
    end
  end
end
