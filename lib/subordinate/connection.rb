# Connection
require "faraday_middleware"

module Subordinate
  module Connection
    def connection(options = {})
      options = {
        :ssl              => { :verify => false }
      }.merge(options)

      connection = Faraday.new(options) do |build|
        build.use FaradayMiddleware::Mashify
        build.use FaradayMiddleware::ParseJson, :content_type => /\bjson$/
        build.adapter  Faraday.default_adapter
      end

      connection
    end
  end
end