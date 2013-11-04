# Connection
require "json"
require "faraday_middleware"
require "subordinate/error"

module Subordinate
  module Connection
    def connection(options = {})
      options = {
        :ssl              => { :verify => false }
      }.merge(options)

      connection = Faraday.new(options) do |build|
        build.request :url_encoded
        if authenticated?
          build.request :basic_auth, self.username, self.api_token
        end
        build.response :mashify
        build.response :json, :content_type => /\bjson$/
        build.use ErrorMiddleware
        build.adapter  Faraday.default_adapter
      end

      connection
    end
    # Middleware for responding to Errors returned from the api
    class ErrorMiddleware < Faraday::Middleware
      def initialize(app)
        @app = app
      end

      def call(env)
        @app.call(env).on_complete do |env|
          if error = Subordinate::Error.from(env[:response])
            raise error
          end
        end
      end
    end
  end
end
