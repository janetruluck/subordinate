# Queue
module Subordinate
  class Client
    # Queue management and configuration
    #
    # @see https://ci.jenkins-ci.org/job/jenkins_rc_branch/api/
    module Queue
      # Returns the current build queue for the system
      #
      # @see http://ci.jenkins-ci.org/queue/api/
      #
      # @return [Hashie::Mash] build queue response
      #
      # @example Get the current build queue
      #   Subordinate::Client.build_queue
      #
      # @author Jason Truluck
      def build_queue(options = {})
        get("queue/api/json", options)
      end
    end
  end
end