require "spec_helper"

# Queue Spec
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

  describe "#build_queue", :vcr do
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