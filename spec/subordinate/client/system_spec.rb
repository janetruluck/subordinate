require "spec_helper"

# Client Spec
describe Subordinate::Client do
  before do
    Subordinate.reset!
    Subordinate.configure do |c|
      c.subdomain = ENV["SUBDOMAIN"]
      c.domain    = ENV["DOMAIN"]
      c.port      = ENV["PORT"]
      c.ssl       = false
    end
  end
  let(:subordinate) { Subordinate::Client.new(:username => ENV["USERNAME"], :api_token => ENV["TOKEN"]) }

  describe "#root", :vcr do
    let(:current_response) { subordinate.root }

    it "returns the root response", :vcr do
      current_response.should_not be_nil
    end

    describe "methods" do
      it "contains the assignedLabels" do
        current_response.should respond_to(:assignedLabels)
      end

      it "contains the mode" do
        current_response.should respond_to(:mode)
      end

      it "contains the nodeDescription" do
        current_response.should respond_to(:nodeDescription)
      end

      it "contains the nodeName" do
        current_response.should respond_to(:nodeName)
      end

      it "contains the numExecutors" do
        current_response.should respond_to(:numExecutors)
      end

      it "contains the description" do
        current_response.should respond_to(:description)
      end

      it "contains the jobs" do
        current_response.should respond_to(:jobs)
      end

      it "contains the overallLoad" do
        current_response.should respond_to(:overallLoad)
      end

      it "contains the primaryView" do
        current_response.should respond_to(:primaryView)
      end

      it "contains the quietingDown" do
        current_response.should respond_to(:quietingDown)
      end

      it "contains the slaveAgentPort" do
        current_response.should respond_to(:slaveAgentPort)
      end

      it "contains the unlabeledLoad" do
        current_response.should respond_to(:unlabeledLoad)
      end

      it "contains the useCrumbs" do
        current_response.should respond_to(:useCrumbs)
      end

      it "contains the useSecurity" do
        current_response.should respond_to(:useSecurity)
      end

      it "contains the views" do
        current_response.should respond_to(:views)
      end
    end
  end

  describe "#quiet_down" do
    it "will shut down the server" do
      stub_request(:post, "#{subordinate.api_endpoint}/quietDown").
      to_return(:status => 302, :body => "", :headers => {})

      subordinate.quiet_down.should == 302
    end
  end

  describe "#cancel_quiet_down" do
    it "will cancel a shut down request to the server" do
      stub_request(:post, "#{subordinate.api_endpoint}/cancelQuietDown").
      to_return(:status => 302, :body => "", :headers => {})

      subordinate.cancel_quiet_down.should == 302
    end
  end

  # Because vcr makes real requests the first time when redoing cassettes the restart specs must be
  # commented out since random order is used.
  describe "#restart" do
    it "will force restart the jenkins server" do
      stub_request(:post, "#{subordinate.api_endpoint}/restart").
      to_return(:status => 302, :body => "", :headers => {})

      subordinate.restart.should == 302
    end
  end

  describe "#safe_restart" do
    it "will restart the jenkins server" do
      stub_request(:post, "#{subordinate.api_endpoint}/safeRestart").
      to_return(:status => 302, :body => "", :headers => {})

      subordinate.safe_restart.should == 302
    end
  end
end