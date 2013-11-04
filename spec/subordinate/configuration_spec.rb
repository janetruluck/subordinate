# Configuration Spec
require "spec_helper"

describe Subordinate::Client do
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

      it "builds an endpoint with the domain" do
        Subordinate.api_endpoint.should eq("https://#{domain}")
      end
    end

    # SUBDOMAIN
    describe "with a subdomain" do
      before do
        Subordinate.reset!
        Subordinate.configure do |c|
          c.domain = domain
          c.subdomain = subdomain
        end
      end

      it "builds an endpoint with the subdomain" do
        Subordinate.api_endpoint.should eq("https://#{subdomain}.#{domain}")
      end
    end

    # PORT
    describe "with a port" do
      before do
        Subordinate.reset!
        Subordinate.configure do |c|
          c.domain = domain
          c.port = port
        end
      end

      it "builds an endpoint with the port" do
        Subordinate.api_endpoint.should eq("https://#{domain}:#{port}")
      end
    end

    # SSL
    describe "with a ssl" do
      before do
        Subordinate.reset!
        Subordinate.configure do |c|
          c.domain = domain
          c.ssl = ssl
        end
      end

      it "builds an endpoint with the ssl set to false" do
        Subordinate.api_endpoint.should eq("http://#{domain}")
      end

      it "builds an endpoint with the ssl set to true" do
        Subordinate.ssl = true
        Subordinate.api_endpoint.should eq("https://#{domain}")
      end
    end
  end
end
