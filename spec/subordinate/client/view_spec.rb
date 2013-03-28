require "spec_helper"

auth = YAML::load(File.open(File.expand_path("../../../fixtures/authentications.yml", __FILE__)))

# View Spec
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

  describe "#view", :vcr do
    let(:current_response) { subordinate.view(auth["view"]) }

    it "returns the view response" do
      current_response.should_not be_nil
    end

    context "methods" do
      it "responds to .description" do
        current_response.should respond_to(:description)
      end

      it "responds to .jobs" do
        current_response.should respond_to(:jobs)
      end

      it "responds to .name" do
        current_response.should respond_to(:name)
      end

      it "responds to .property" do
        current_response.should respond_to(:property)
      end

      it "responds to .url" do
        current_response.should respond_to(:url)
      end
    end
  end

  describe "#add_job_to_view" do
    it "responds with a success" do
      stub_request(:post, "#{subordinate.api_endpoint}/view/#{auth['view']}/addJobToView").
      to_return(:status => 200, :body => "", :headers => {})

      res = subordinate.add_job_to_view(auth['view'], auth['job']).status.should == 200
    end
  end

  describe "#remove_job_from_view" do
    it "responds with a success" do
      stub_request(:post, "#{subordinate.api_endpoint}/view/#{auth['view']}/removeJobFromView").
      to_return(:status => 200, :body => "", :headers => {})

      subordinate.remove_job_from_view(auth['view'], auth['job']).status.should == 200
    end
  end
end