# Authentication Module
module Subordinate
  module Authentication
    def authenticated?
      !!(username && api_token)
    end
  end
end
