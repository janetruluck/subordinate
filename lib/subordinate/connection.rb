# Connection
require "faraday_middleware"

module Subordinate
  module Connection
    def connection(options = {})
      debug = options.delete(:debug)
      options = {
        :ssl => { :verify => false }
      }.merge(options)

      connection = Faraday.new(options) do |build|
        build.request :url_encoded
        build.response :logger if debug
        build.use FaradayMiddleware::Mashify
        build.use FaradayMiddleware::ParseJson, :content_type => /\bjson$/
        build.adapter  Faraday.default_adapter
      end

      # Authentication
      connection.basic_auth(self.username, self.api_token)

      connection
    end
  end
end
