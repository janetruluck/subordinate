# Configuration Spec
require "spec_helper"

describe Subordinate::Client do
  describe "configuration" do
    let(:domain)    { "woofound.com" }
    let(:subdomain) { "awesome" }
    let(:port)      { 2000 }
    let(:ssl)       { false }

    before(:each){
      Subordinate.reset!
    }

    describe "with a domain" do
      it "builds an endpoint with the domain" do
        Subordinate.reset!
        client = Subordinate.new(domain: domain)
        client.api_endpoint.should eq("https://#{domain}")
      end
    end

    # SUBDOMAIN
    describe "with a subdomain" do
      it "builds an endpoint with the subdomain" do
        client = Subordinate.new(domain: domain, subdomain: subdomain)
        client.api_endpoint.should eq("https://#{subdomain}.#{domain}")
      end
    end

    # PORT
    describe "with a port" do
      it "builds an endpoint with the port" do
        client = Subordinate.new(domain: domain, port: port)
        client.api_endpoint.should eq("https://#{domain}:#{port}")
      end
    end

    # SSL
    describe "with a ssl" do
      it "builds an endpoint with the ssl set to false" do
        client = Subordinate.new(domain: domain, ssl: false)
        client.api_endpoint.should eq("http://#{domain}")
      end

      it "builds an endpoint with the ssl set to true" do
        client = Subordinate.new(domain: domain, ssl: true)
        client.api_endpoint.should eq("https://#{domain}")
      end
    end
  end
end
