# Authentication Module
module Subordinate
  module Authentication
    def authentication
      if username && api_token
        { :username => username, :api_token => api_token}
      else
        {}
      end
    end

    def authenticated?
      !authentication.empty?
    end

    def username_and_token(username = "", api_token = "")
      return if username.nil? || api_token.nil?
      self.username   = username
      self.api_token  = api_token
    end
  end
end