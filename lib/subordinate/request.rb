require 'multi_json'

module Subordinate
  module Request
    def get(path, options = {})
      response = request(:get, path, options)
      response.body
    end

    def post(path, options = {})
      response = request(:post, path, options)
      response
    end

    private
    def request(method, path, options = {})
      url = options.delete(:endpoint) || api_endpoint

      connection_options = {
        :url => url
      }

      response = connection(connection_options).send(method) do |request|
        case method
        when :get
          request.url(path, options)
        when :post
          with_query_params = options.delete(:with_query_params) || false
          if with_query_params
            request.url(path, options)
          else
            request.path = path
            request.body = MultiJson.dump(options) unless options.empty?
          end
        end
      end
      response
    end
  end
end