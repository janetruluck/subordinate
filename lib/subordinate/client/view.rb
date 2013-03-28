# View
module Subordinate
  class Client
    # View
    #
    # @see https://ci.jenkins-ci.org/view/All%20Unstable/api/
    module View
      # Returns the specified view
      #
      # @see http://ci.jenkins-ci.org:8080/view/All%20Unstable/api/json?pretty=true
      #
      # @param view_name [String] the name of the view you want inforamtion on
      #
      # @return [Hashie::Mash] response from the specified view
      #
      # @example Get the current view
      #   Subordinate::Client.view("My-Awesome-View")
      #
      # @author Jason Truluck
      def view(view_name, options = {})
        get("view/#{view_name}/api/json", options)
      end

      # Add a job to the Jenkins view
      #
      # @see http://ci.jenkins-ci.org:8080/view/All%20Unstable/api/
      #
      # @param view_name [String] the name of the view you want inforamtion on
      # @param job [String] the name of the job you want to add
      #
      # @return [Integer] status the status of the request
      #
      # @example Add the selected Job to the Jenkins View
      #   Subordinate::Client.add_job_to_view("My-Awesome-View", "My-Awesome-Job")
      #
      # @author Jason Truluck
      def add_job_to_view(view_name, job, options = {})
        options.merge(
          :name => job
        )
        post("view/#{view_name}/addJobToView", options)
      end

      # Remove a job to the Jenkins view
      #
      # @see http://ci.jenkins-ci.org:8080/view/All%20Unstable/api/
      #
      # @param view_name [String] the name of the view you want inforamtion on
      # @param job [String] the name of the job you want to remove
      #
      # @return [Integer] status the status of the request
      #
      # @example Remove the selected job from the Jenkins View
      #   Subordinate::Client.remove_job_from_view("My-Awesome-View", "My-Awesome-Job")
      #
      # @author Jason Truluck
      def remove_job_from_view(view_name, job, options = {})
        options.merge(
          :name => job
        )
        post("view/#{view_name}/removeJobFromView", options)
      end
    end
  end
end