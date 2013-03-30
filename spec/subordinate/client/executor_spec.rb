require "spec_helper"

# Build Executor Spec
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

  describe "#build_executor", :vcr do
    let(:current_response) { subordinate.build_executor }

    it "returns the build_executor response" do
      current_response.should_not be_nil
    end

    context "methods" do
      it "responds to .busyExecutors" do
        current_response.should respond_to(:busyExecutors)
      end

      it "responds to .computer" do
        current_response.should respond_to(:computer)
      end

      it "responds to .displayName" do
        current_response.should respond_to(:displayName)
      end

      it "responds to .totalExecutors" do
        current_response.should respond_to(:totalExecutors)
      end

      describe "within .computer" do
        it "responds to .actions" do
          current_response.computer.first.should respond_to(:actions)
        end

        it "responds to .displayName" do
          current_response.computer.first.should respond_to(:displayName)
        end

        it "responds to .executors" do
          current_response.computer.first.should respond_to(:executors)
        end

        it "responds to .icon" do
          current_response.computer.first.should respond_to(:icon)
        end

        it "responds to .idle" do
          current_response.computer.first.should respond_to(:idle)
        end

        it "responds to .jnlpAgent" do
          current_response.computer.first.should respond_to(:jnlpAgent)
        end

        it "responds to .launchSupported" do
          current_response.computer.first.should respond_to(:launchSupported)
        end

        it "responds to .loadStatistics" do
          current_response.computer.first.should respond_to(:loadStatistics)
        end

        it "responds to .manualLaunchAllowed" do
          current_response.computer.first.should respond_to(:manualLaunchAllowed)
        end

        it "responds to .monitorData" do
          current_response.computer.first.should respond_to(:monitorData)
        end

        it "responds to .numExecutors" do
          current_response.computer.first.should respond_to(:numExecutors)
        end

        it "responds to .offline" do
          current_response.computer.first.should respond_to(:offline)
        end

        it "responds to .offlineCause" do
          current_response.computer.first.should respond_to(:offlineCause)
        end

        it "responds to .offlineCauseReason" do
          current_response.computer.first.should respond_to(:offlineCauseReason)
        end

        it "responds to .oneOffExecutors" do
          current_response.computer.first.should respond_to(:oneOffExecutors)
        end

        it "responds to .temporarilyOffline" do
          current_response.computer.first.should respond_to(:temporarilyOffline)
        end
      end
    end
  end
end