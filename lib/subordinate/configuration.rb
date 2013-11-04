#Configuration
module Subordinate
  module Configuration
    VALID_OPTIONS_KEYS = [
      :username,
      :api_token,
      :api_endpoint,
      :domain,
      :subdomain,
      :port,
      :ssl
    ]

    attr_accessor(*VALID_OPTIONS_KEYS)

    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}){|o,k| o.merge!(k => send(k)) }
    end

    def reset!
      VALID_OPTIONS_KEYS.each {|key| class_eval(%Q{key = nil}) }
      self.ssl = true
    end
  end
end
