# Job Spec
require "spec_helper"

describe Subordinate::Client do
  before do
    Subordinate.reset!
    Subordinate.configure do |c|
      c.subdomain = "jenkins"
      c.domain    = "example.com"
      c.port      = 8080
      c.ssl       = false
    end
  end

  let(:subordinate) { Subordinate::Client.new(:username => "someusername", :api_token => "sometoken") }

  describe "#job" do
    before(:each) { stub_jenkins(:get, "/job/Some-Job/api/json", "job.json") }

    let(:current_response) { subordinate.job("Some-Job") }

    it "should return the job response" do
      current_response.should_not be_nil
    end

    context "methods" do
      it "responds to .actions" do
        current_response.should respond_to(:actions)
      end

      it "responds to .description" do
        current_response.should respond_to(:description)
      end

      it "responds to .displayName" do
        current_response.should respond_to(:displayName)
      end

      it "responds to .displayNameOrNull" do
        current_response.should respond_to(:displayNameOrNull)
      end

      it "responds to .name" do
        current_response.should respond_to(:name)
      end

      it "responds to .url" do
        current_response.should respond_to(:url)
      end

      it "responds to .buildable" do
        current_response.should respond_to(:buildable)
      end

      it "responds to .builds" do
        current_response.should respond_to(:builds)
      end

      it "responds to .color" do
        current_response.should respond_to(:color)
      end

      it "responds to .firstBuild" do
        current_response.should respond_to(:firstBuild)
      end

      it "responds to .healthReport" do
        current_response.should respond_to(:healthReport)
      end

      it "responds to .inQueue" do
        current_response.should respond_to(:inQueue)
      end

      it "responds to .keepDependencies" do
        current_response.should respond_to(:keepDependencies)
      end

      it "responds to .lastBuild" do
        current_response.should respond_to(:lastBuild)
      end

      it "responds to .lastCompletedBuild" do
        current_response.should respond_to(:lastCompletedBuild)
      end

      it "responds to .lastFailedBuild" do
        current_response.should respond_to(:lastFailedBuild)
      end

      it "responds to .lastStableBuild" do
        current_response.should respond_to(:lastStableBuild)
      end

      it "responds to .lastSuccessfulBuild" do
        current_response.should respond_to(:lastSuccessfulBuild)
      end

      it "responds to .lastUnstableBuild" do
        current_response.should respond_to(:lastUnstableBuild)
      end

      it "responds to .lastUnsuccessfulBuild" do
        current_response.should respond_to(:lastUnsuccessfulBuild)
      end

      it "responds to .nextBuildNumber" do
        current_response.should respond_to(:nextBuildNumber)
      end

      it "responds to .property" do
        current_response.should respond_to(:property)
      end

      it "responds to .queueItem" do
        current_response.should respond_to(:queueItem)
      end

      it "responds to .concurrentBuild" do
        current_response.should respond_to(:concurrentBuild)
      end

      it "responds to .downstreamProjects" do
        current_response.should respond_to(:downstreamProjects)
      end

      it "responds to .scm" do
        current_response.should respond_to(:scm)
      end

      it "responds to .upstreamProjects" do
        current_response.should respond_to(:upstreamProjects)
      end
  end
  end

  describe "#build_job" do
    it "builds the job specified" do
      stub_jenkins(:post, "/job/Some-Job/build", 302, "empty.json")

      subordinate.build_job("Some-Job").should  == 302
    end
  end

  describe "#build_job_with_params" do
    it "builds the job specified with the parameters specified" do
      stub_jenkins(:post, "/job/Some-Job/buildWithParameters", 302, "empty.json")

      subordinate.build_job_with_params("Some-Job").should  == 302
    end
  end

  describe "#disable_job" do
    it "disables the specified job" do
      stub_jenkins(:post, "/job/Some-Job/disable", 302, "empty.json")

      subordinate.disable_job("Some-Job").should == 302
    end
  end

  describe "#enable_job" do
    it "enables the specified job" do
      stub_jenkins(:post, "/job/Some-Job/enable", 302, "empty.json")

      subordinate.enable_job("Some-Job").should == 302
    end
  end

  describe "#delete_job" do
    it "deletes the specified job" do
      stub_jenkins(:post, "/job/Some-Job/delete", 302, "empty.json")

      subordinate.delete_job("Some-Job").should == 302
    end
  end

  describe ".job_config" do
    let(:file) { File.read(File.expand_path("../../../support/mocks/job_config.xml", __FILE__)) }

    it "retrieves a config file for the job" do
      stub_jenkins(:get, "/job/Some-Job/config.xml", 200, "application/xml", "job_config.xml")

      subordinate.job_config("Some-Job").should eq(file)
    end
  end

  describe ".job_config" do
    let(:new_file) { File.read(File.expand_path("../../../support/mocks/new_config.xml", __FILE__)) }

    it "retrieves a config file for the job" do
      stub_jenkins(:post, "/job/Some-Job/config.xml", 200, "application/xml", "job_config.xml")

      subordinate.update_job_config("Some-Job", new_file).should eq(new_file).body
    end
  end
end
