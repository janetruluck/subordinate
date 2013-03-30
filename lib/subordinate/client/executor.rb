# Executor
module Subordinate
  class Client
    # Executor information
    #
    # @see https://ci.jenkins-ci.org/computer/api/
    module Executor
      # Returns the current build executor for the system
      #
      # @see http://ci.jenkins-ci.org/computer/api/json?pretty=true
      #
      # @return [Hashie::Mash] build executor response
      #
      # @example Get information about the build executor
      #   Subordinate::Client.build_executor
      #
      # @author Jason Truluck
      def build_executor(options = {})
        get("computer/api/json", options)
      end
    end
  end
end