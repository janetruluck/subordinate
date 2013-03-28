# Load
module Subordinate
  class Client
    # Load statistics
    #
    # @see https://ci.jenkins-ci.org/job/jenkins_rc_branch/api/
    module Load
      # Returns the current load statistics of the Jenkins server
      #
      # @see https://ci.jenkins-ci.org:8080/queue/api/
      #
      # @return [Hashie::Mash] load statistics response
      #
      # @example Get the current load statistics
      #   Subordinate::Client.load_statistics
      #
      # @author Jason Truluck
      def load_statistics(options = {})
        get("overallLoad/api/json", options)
      end
    end
  end
end