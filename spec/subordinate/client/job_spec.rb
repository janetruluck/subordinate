require "spec_helper"

auth = YAML::load(File.open(File.expand_path("../../../fixtures/authentications.yml", __FILE__)))

# Client Spec
describe Subordinate::Client do
  before do
    Subordinate.reset!
    Subordinate.configure do |c|
      c.subdomain = auth["subdomain"]
      c.domain    = auth["domain"]
      c.port      = auth["port"]
      c.ssl       = false
    end
  end
  let(:subordinate) { Subordinate::Client.new(:username => auth["username"], :api_token => auth["token"]) }

  describe "#job", :vcr do
    let(:current_response) { subordinate.job(auth["job"]) }

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
      stub_request(:post, "#{subordinate.api_endpoint}/job/#{auth['job']}/build").
      to_return(:status => 302, :body => "", :headers => {})

      subordinate.build_job(auth["job"]).should  == 302
    end
  end

  describe "#disable_job" do
    it "disables the specified job" do
      stub_request(:post, "#{subordinate.api_endpoint}/job/#{auth['job']}/disable").
      to_return(:status => 302, :body => "", :headers => {})

      subordinate.disable_job(auth["job"]).should == 302
    end
  end

  describe "#enable_job" do
    it "enables the specified job" do
      stub_request(:post, "#{subordinate.api_endpoint}/job/#{auth['job']}/enable").
      to_return(:status => 302, :body => "", :headers => {})

      subordinate.enable_job(auth["job"]).should == 302
    end
  end

  describe "#delete_job" do
    it "deletes the specified job" do
      stub_request(:post, "#{subordinate.api_endpoint}/job/#{auth['job']}/delete").
      to_return(:status => 302, :body => "", :headers => {})

      subordinate.delete_job(auth["job"]).should == 302
    end
  end
end