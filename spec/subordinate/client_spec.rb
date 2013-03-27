require "spec_helper"

auth = YAML::load(File.open(File.expand_path("../../fixtures/authentications.yml", __FILE__)))

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

  describe "#initialize" do
    it "can be initialized" do
      Subordinate::Client.new.class.should == Subordinate::Client
    end

    it "works with basic username and api token", :vcr do
      Subordinate::Client.new(:username => auth["username"], :api_token => auth["token"]).root
      .should_not
      raise_exception
    end
  end
end