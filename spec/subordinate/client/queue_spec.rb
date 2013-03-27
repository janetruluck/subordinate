require "spec_helper"

auth = YAML::load(File.open(File.expand_path("../../../fixtures/authentications.yml", __FILE__)))

# Queue Spec
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