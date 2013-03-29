# People
module Subordinate
  class Client
    # View Users on the Jenkins server
    #
    # @see https://ci.jenkins-ci.org/asynchPeople/api/json?pretty=true
    module People
      # Returns the users on the Jenkins server
      #
      # @see http://ci.jenkins-ci.org/asynchPeople/api/json?pretty=true
      #
      # @return [Hashie::Mash] users on the Jenkins server
      #
      # @example Get the users on the Jenkins server
      #   Subordinate::Client.people
      #
      # @author Jason Truluck
      def people(options = {})
        get("asynchPeople/api/json", options)
      end
    end
  end
end