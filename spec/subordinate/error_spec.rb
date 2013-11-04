# spec/subordinate/error.rb
require "spec_helper"

describe Subordinate::Error do
  before do
    Subordinate.reset!
    Subordinate.configure do |c|
      c.subdomain = "jenkins"
      c.domain    = "example.com"
      c.port      = 8080
      c.ssl       = false
    end
  end

  let(:client) { Subordinate::Client.new(:username => "someusername", :api_token => "sometoken") }

  describe "#from" do
    describe "400 Error" do
      it "raises a Subordinate::BadRequest error" do
        stub_jenkins(:get, "/api/json", 400, "application/json", "base.json")

        expect{ client.root }.to raise_error(Subordinate::BadRequest)
      end
    end

    describe "401 Error" do
      it "raises a Subordinate::Unauthorized error" do
        stub_jenkins(:get, "/api/json", 401, "base.json")

        expect{ client.root }.to raise_error(Subordinate::Unauthorized)
      end
    end

    describe "404 Error" do
      it "raises a Subordinate::NotFound error" do
        stub_jenkins(:get, "/api/json", 404, "base.json")

        expect{ client.root }.to raise_error(Subordinate::NotFound)
      end
    end

    describe "422 Error" do
      it "raises a Subordinate::UnprocessableEntity error" do
        stub_jenkins(:get, "/api/json", 422, "base.json")

        expect{ client.root }.to raise_error(Subordinate::UnprocessableEntity)
      end
    end

    describe "500 Error" do
      it "raises a Subordinate::InternalServerError error" do
        stub_jenkins(:get, "/api/json", 500, "base.json")

        expect{ client.root }.to raise_error(Subordinate::InternalServerError)
      end
    end
  end
end
