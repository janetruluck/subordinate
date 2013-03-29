require "spec_helper"

auth = YAML::load(File.open(File.expand_path("../../../fixtures/authentications.yml", __FILE__)))

# Queue Spec
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

  describe "#people", :vcr do
    let(:current_response) { subordinate.people }

    it "returns the users response" do
      current_response.should_not be_nil
    end

    context "methods" do

      it "responds to .users" do
        current_response.should respond_to(:users)
      end

      describe "within .users" do
        it "responds to .lastChange" do
          current_response.users.first.should respond_to(:lastChange)
        end

        it "responds to .project" do
          current_response.users.first.should respond_to(:project)
        end

        it "responds to .user" do
          current_response.users.first.should respond_to(:user)
        end

        describe "within .project" do
          it "responds to .name" do
            current_response.users.first.project.should respond_to(:name)
          end

          it "responds to .url" do
            current_response.users.first.project.should respond_to(:url)
          end
        end

        describe "within .user" do
          it "responds to .absoluteUrl" do
            current_response.users.first.user.should respond_to(:absoluteUrl)
          end

          it "responds to .fullName" do
            current_response.users.first.user.should respond_to(:fullName)
          end
        end
      end
    end
  end
end