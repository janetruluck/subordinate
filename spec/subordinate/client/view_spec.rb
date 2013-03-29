require "spec_helper"

# View Spec
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

  describe "#view", :vcr do
    let(:current_response) { subordinate.view(ENV["VIEW"]) }

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

  describe "#all_views", :vcr do
    let(:current_response) { subordinate.all_views }

    it "returns the view response" do
      current_response.should_not be_nil
    end

    context "methods" do
      it "respond to .views" do
        current_response.should respond_to(:views)
      end

      describe "within views" do
        it "respond to .jobs" do
          current_response.views.first.should respond_to(:jobs)
        end

        it "respond to .name" do
          current_response.views.first.should respond_to(:name)
        end

        it "respond to .url" do
          current_response.views.first.should respond_to(:url)
        end
      end
    end
  end

  describe "#add_job_to_view" do
    it "responds with a success" do
      stub_request(:post, "#{subordinate.api_endpoint}/view/#{ENV["VIEW"]}/addJobToView").
      to_return(:status => 200, :body => "", :headers => {})

      subordinate.add_job_to_view(ENV["VIEW"], ENV["JOB"]).status.should == 200
    end
  end

  describe "#remove_job_from_view" do
    it "responds with a success" do
      stub_request(:post, "#{subordinate.api_endpoint}/view/#{ENV["VIEW"]}/removeJobFromView").
      to_return(:status => 200, :body => "", :headers => {})

      subordinate.remove_job_from_view(ENV["VIEW"], ENV["JOB"]).status.should == 200
    end
  end
end