# System
module Subordinate
  class Client
    # System level tasks for Jenkins Server. These functions typically require admin
    # level privileges to execute.
    #
    # @see https://ci.jenkins-ci.org/api/
    module System

      # Returns the response from the root api
      #
      # @see https://ci.jenkins-ci.org/api/json?pretty=true
      #
      # @return [Hashie::Mash] State is the server is currently up
      #
      # @example Get the root api response
      #   Subordinate::Client.root
      def root(options = {})
        get('/api/json', options)
      end

      # Shuts down Jenkins Server
      #
      # @see https://ci.jenkins-ci.org/api/
      #
      # @return [Integer] response code
      #
      # @example Send a quiet down request to the Jenkins server
      #   Subordinate::Client.quiet_down
      def quiet_down(options = {})
        post('/quietDown', options)
      end

      # Cancel a shut down request to the Jenkins Server
      #
      # @see https://ci.jenkins-ci.org/api/
      #
      # @return [Integer] response code
      #
      # @example Send a quiet down request to the Jenkins server
      #   Subordinate::Client.cancel_quiet_down
      def cancel_quiet_down(options = {})
        post('/cancelQuietDown', options)
      end

      # Restarts the jenkins server, will not wait for jobs to finish
      #
      # @see https://ci.jenkins-ci.org/api/
      #
      # @return [Integer] response code
      #
      # @example Sends a force restart request to the Jenkins server
      #   Subordinate::Client.restart(true)
      def restart(options = {})
        post("restart", options)
      end

      # Safely Restarts the jenkins server, will wait for jobs to finish
      #
      # @see https://ci.jenkins-ci.org/api/
      #
      # @return [Integer] response code
      #
      # @example Sends a restart request to the Jenkins server (defaults to no force)
      #   Subordinate::Client.restart
      def safe_restart(options = {})
        post("safeRestart", options)
      end
    end
  end
end
