# lib/subordinate/error.rb
module Subordinate
  class Error < StandardError
    attr_accessor :response

    def self.from(response)
      status  = response.status

      if klass = case status
                 when 400 then Subordinate::BadRequest
                 when 401 then Subordinate::Unauthorized
                 when 404 then Subordinate::NotFound
                 when 422 then Subordinate::UnprocessableEntity
                 when 500 then Subordinate::InternalServerError
                 end

        klass.new(response)
      end
    end

    def initialize(response)
      @response = response
      super(error_message)
    end

    private
    def error_message
      message =  "#{response.env[:method].upcase} "
      message << "#{response.env[:url].to_s} | "
      message << "#{response.status} "
      message
    end
  end

  # Raised when Jenkins REST Api returns a 400 HTTP status code
  class BadRequest < Error; end
  # Raised when Jenkins REST Api returns a 401 HTTP status code
  class Unauthorized < Error; end
  # Raised when Jenkins REST Api returns a 404 HTTP status code
  class NotFound < Error; end
  # Raised when Jenkins REST Api returns a 422 HTTP status code
  class UnprocessableEntity < Error; end
  # Raised when Jenkins REST Api returns a 500 HTTP status code
  class InternalServerError < Error; end
end
