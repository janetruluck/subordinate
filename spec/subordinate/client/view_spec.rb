# View Spec
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

  let(:subordinate) { Subordinate::Client.new(:username => "someusername", :api_token => "sometoken") }

  describe "#view" do
    before(:each) { stub_jenkins(:get, "/view/someview/api/json", "view.json") }

    let(:current_response) { subordinate.view("someview") }

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

  describe "#all_views" do
    before(:each) { stub_jenkins(:get, "/api/json?tree=views%5Bname,url,jobs%5Bname,url%5D%5D", "views.json") }

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
      stub_jenkins(:post, "/view/someview/addJobToView?name=somejob", 200, "empty.json")

      subordinate.add_job_to_view("someview", "somejob")
      expect(subordinate.last_response.status).to eq(200)
    end
  end

  describe "#remove_job_from_view" do
    it "responds with a success" do
      stub_jenkins(:post, "/view/someview/removeJobFromView?name=somejob", 200, "empty.json")

      subordinate.remove_job_from_view("someview", "somejob")
      expect(subordinate.last_response.status).to eq(200)
    end
  end
end
