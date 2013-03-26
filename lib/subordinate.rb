require "subordinate/version"
require "subordinate/configuration"
require "subordinate/client"

module Subordinate
  extend Configuration

  class << self
    # Alias for Subordinate::Client.new
    # @return [Subordinate::Client]
    def new(options = {})
      Subordinate::Client.new(options)
    end

    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end