# Queue Spec
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

  describe "#build_queue" do
    before(:each) { stub_jenkins(:get, "/queue/api/json", "queue.json") }

    let(:current_response) { subordinate.build_queue }

    it "returns the build queue response" do
      current_response.should_not be_nil
    end

    context "methods" do
      it "responds to .items" do
        current_response.should respond_to(:items)
      end
    end
  end
end
