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
      VALID_OPTIONS_KEYS.each {|key| instance_variable_set("@#{key}".to_sym, nil) }
      self.ssl = true
      self
    end
  end
end
