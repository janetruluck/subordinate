# Build
module Subordinate
  class Client
    # Build management and configuration
    #
    # @see https://ci.jenkins-ci.org/job/jenkins_rc_branch/322/api/
    module Build
      # Returns the response with information about the specific build
      #
      # @see https://ci.jenkins-ci.org/job/jenkins_rc_branch/322/api/json?pretty=true
      #
      # @param [String] job the job that you want to retrieve information about
      # @param [String] build_number the build number that you want to retrieve information about
      #
      # @return [Hashie::Mash] build response
      #
      # @example Get the build api response
      #   Subordinate::Client.build("My-Job-I-Want-Info-On", 5)
      #
      # @author Jason Truluck
      def build(job, build_number, options = {})
        get("job/#{job}/#{build_number}/api/json", options)
      end

      # Returns the builds timestamp
      # This methods accepts the simple data formatter seen here:
      # @see http://docs.oracle.com/javase/1.5.0/docs/api/java/text/SimpleDateFormat.html
      #
      # @see https://ci.jenkins-ci.org/job/jenkins_rc_branch/322/buildTimestamp
      #
      # @param [String] job the job that you want to retrieve the build number from
      # @param [String] build_number the build number that you want to retrieve information about
      # @param [String] format the timestamp format you want returned
      #
      # @return [String] build timestamp
      #
      # @example Get the first builds timestamp
      #   Subordinate::Client.build_timestamp("My-Job-I-Want-Info-On", 1)
      #
      # @example Get the first builds timestamp in format "yyyy/MM/dd"
      #   Subordinate::Client.build_timestamp("My-Job-I-Want-Info-On", 1, "yyyy/MM/dd")
      #
      # @author Jason Truluck
      def build_timestamp(job, build_number, format = nil, options = {})
        options.merge!(
          :format => format
        ) if !format.nil?

        get("job/#{job}/#{build_number}/buildTimestamp", options)
      end

      # Returns the console output for the build specified
      #
      # @see https://ci.jenkins-ci.org/job/jenkins_rc_branch/322/logText/progressiveText?start=0
      #
      # @param [String] job the job that you want to retrieve the build number from
      # @param [String] build_number the build number that you want to retrieve information about
      # @param [String] start_offset the byte offset of where you start.
      # @param [Boolean] pre if you want the output to be returned in a pre-formatted foramat for use in <pre> tags
      #
      # @return [String] console output of build
      #
      # @example Get the console output of the first build
      #   Subordinate::Client.console_output_for_build("My-Job-I-Want-Info-On", 1)
      #
      # @example Get the console output of the first build pre formatted
      #   Subordinate::Client.console_output_for_build("My-Job-I-Want-Info-On", 1, 0, true)
      #
      # @example Get the console output of the first build starting from the 200th byte
      #   Subordinate::Client.console_output_for_build("My-Job-I-Want-Info-On", 1, 200)
      #
      # @author Jason Truluck
      def console_output_for_build(job, build_number, start_offset = 0, pre = false, options = {})
        options.merge!(
          :start => start_offset
        )
        if pre
          get("job/#{job}/#{build_number}/logText/pregressiveHTML", options)
        else
          get("job/#{job}/#{build_number}/logText/pregressiveText", options)
        end
      end
    end
  end
end