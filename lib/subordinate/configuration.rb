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
      :ssl,
      :depth
    ]

    attr_accessor(*VALID_OPTIONS_KEYS)

    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}){|o,k| o.merge!(k => send(k)) }
    end

    def reset!
      self.username            = nil
      self.api_token           = nil
      self.domain              = nil
      self.subdomain           = nil
      self.port                = nil
      self.ssl                 = true
      self.depth               = nil
    end
  end
end
