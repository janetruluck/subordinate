# Configuration Spec
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

  describe "configuration" do
    let(:domain)    { "woofound.com" }
    let(:subdomain) { "awesome" }
    let(:port)      { 2000 }
    let(:ssl)       { false }

    describe "with a domain" do
      before do
        Subordinate.reset!
        Subordinate.configure do |c|
          c.domain = domain
        end
      end

      let(:client) { Subordinate.new }

      it "sets the domain for the client" do
        client.domain.should == domain
      end

      it "builds an endpoint with the domain" do
        client.api_endpoint.should include(domain)
      end
    end

    # SUBDOMAIN
    describe "with a subdomain" do
      before do
        Subordinate.reset!
        Subordinate.configure do |c|
          c.subdomain = subdomain
        end
      end

      let(:client) { Subordinate.new }

      it "sets the subdomain for the client" do
        client.subdomain.should == subdomain
      end

      it "builds an endpoint with the subdomain" do
        client.api_endpoint.should include(subdomain)
      end
    end

    describe "without a subdomain" do
      it "builds an endpoint without a subdomain" do
        client = Subordinate.new(:subdomain => nil)
        client.api_endpoint.should == "http://example.com:8080"
      end
    end

    # PORT
    describe "with a port" do
      before do
        Subordinate.reset!
        Subordinate.configure do |c|
          c.port = port
        end
      end

      let(:client) { Subordinate.new }

      it "sets the port for the client" do
        client.port.should == port
      end

      it "builds an endpoint with the port" do
        client.api_endpoint.should include("#{port}")
      end
    end

    describe "without a port" do
      it "builds an endpoint without a port" do
        client = Subordinate.new(:port => nil)
        client.api_endpoint.should == "http://jenkins.example.com"
      end
    end

    # SSL
    describe "with a ssl" do
      before do
        Subordinate.reset!
        Subordinate.configure do |c|
          c.ssl = ssl
        end
      end

      let(:client) { Subordinate.new }

      it "sets the ssl for the client" do
        client.ssl.should == ssl
      end

      it "builds an endpoint with the ssl set to false" do
        client.api_endpoint.should include("http://")
      end

      it "builds an endpoint with the ssl set to true" do
        client = Subordinate.new(:ssl => true)
        client.api_endpoint.should include("https://")
      end
    end
  end
end
