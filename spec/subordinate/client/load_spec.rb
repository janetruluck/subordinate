require "spec_helper"

# Queue Spec
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

  describe "#load_statistics" do
    before(:each) { stub_jenkins(:get, "/overallLoad/api/json", "load_statistics.json") }

    let(:current_response) { subordinate.load_statistics }

    it "returns the load statistics response" do
      current_response.should_not be_nil
    end

    context "methods" do
      it "responds to .busyExecutors" do
        current_response.should respond_to(:busyExecutors)
      end

      it "responds to .queueLength" do
        current_response.should respond_to(:queueLength)
      end

      it "responds to .totalExecutors" do
        current_response.should respond_to(:totalExecutors)
      end

      it "responds to .totalQueueLength" do
        current_response.should respond_to(:totalQueueLength)
      end
    end
  end
end
