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

  describe "#initialize" do
    let(:domain)    { "woofound.com" }
    let(:subdomain) { "awesome" }
    let(:port)      { 2000 }
    let(:ssl)       { false }

    it "can be initialized" do
      Subordinate::Client.new.class.should == Subordinate::Client
    end

    it "is aliased within itself" do
      Subordinate.new.class.should == Subordinate::Client
    end

    it "works with basic username and api token", :vcr do
      Subordinate::Client.new(:username => ENV["USERNAME"], :api_token => ENV["TOKEN"]).root
      .should_not
      raise_exception
    end

    it "generates an endpoint without username and api token" do
      client = Subordinate::Client.new(:api_key => ENV["API_KEY"] )
      client.api_endpoint.should_not include("#{ENV["USERNAME"]}:#{ENV["API_KEY"]}")
    end

    it "can be configured to use a new domain via options" do
      client = Subordinate::Client.new(:api_key => ENV["API_KEY"], :domain => domain )
      client.domain.should == domain
    end

    it "can be configured to use a new subdomain via options" do
      client = Subordinate::Client.new(:api_key => ENV["API_KEY"], :subdomain => subdomain )
      client.subdomain.should == subdomain
    end

    it "can be configured to use a new port via options" do
      client = Subordinate::Client.new(:api_key => ENV["API_KEY"], :port => port )
      client.port.should == port
    end

    it "can be configured to use a different ssl option via options" do
      client = Subordinate::Client.new(:api_key => ENV["API_KEY"], :ssl => ssl )
      client.ssl.should == ssl
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