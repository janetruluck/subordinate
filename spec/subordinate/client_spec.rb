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

    it "is aliased within itself" do
      Subordinate.new.class.should == Subordinate::Client
    end

    it "works with basic username and api token", :vcr do
      Subordinate::Client.new(:username => auth["username"], :api_token => auth["token"]).root
      .should_not
      raise_exception
    end

    it "can be configured to use a new domain via options" do
      domain = "woofound.com"
      client = Subordinate::Client.new(:api_key => ENV["API_KEY"], :domain => domain )
      client.domain.should == domain
    end

    it "can be configured to use a new subdomain via options" do
      subdomain = "awesome"
      client = Subordinate::Client.new(:api_key => ENV["API_KEY"], :subdomain => subdomain )
      client.subdomain.should == subdomain
    end

    it "can be configured to use a new port via options" do
      port = 2000
      client = Subordinate::Client.new(:api_key => ENV["API_KEY"], :port => port )
      client.port.should == port
    end

    it "can be configured to use a different ssl option via options" do
      ssl = false
      client = Subordinate::Client.new(:api_key => ENV["API_KEY"], :ssl => ssl )
      client.ssl.should == ssl
    end

    it "can be configured to use a different depth option via options" do
      depth = false
      client = Subordinate::Client.new(:api_key => ENV["API_KEY"], :depth => depth )
      client.depth.should == depth
    end
  end

  describe "#respond_to?" do
    it "returns true if the method exists" do
      Subordinate.respond_to?(:build_queue).should == true
    end

    it "returns false if the method does not exists" do
      Subordinate.respond_to?(:missing_method).should == false
    end

    it "can check private methods if the 'include_private' flag is true" do
      Subordinate.respond_to?(:request, true).should == true
    end

    it "can not check private methods if the 'include_private' flag is false" do
      Subordinate.respond_to?(:request, false).should == false
    end
  end
end