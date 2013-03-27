# Client Module
require "subordinate/authentication"
require "subordinate/connection"
require "subordinate/request"

require "subordinate/client/job"
require "subordinate/client/system"
require "subordinate/client/build"
require "subordinate/client/queue"

module Subordinate
  class Client
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options = {})
      options = Subordinate.options.merge(options)

      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end

      username_and_token(options[:username], options[:api_token])
      build_endpoint
    end

    # Builds the api endpoint to reach the Jenkins Server
    #
    # @return [String] Endpoint
    #
    # @author Jason Truluck
    def build_endpoint
      endpoint = ssl ? "https://" : "http://"
      endpoint << "#{self.username}:#{self.api_token}@" if self.authenticated?
      endpoint << "#{self.subdomain}.#{self.domain}:#{self.port}"
      endpoint << "?depth=#{self.depth}" if !depth.nil?
      self.api_endpoint = endpoint
    end

    include Subordinate::Authentication
    include Subordinate::Connection
    include Subordinate::Request

    include Subordinate::Client::Job
    include Subordinate::Client::System
    include Subordinate::Client::Build
    include Subordinate::Client::Queue
  end
end