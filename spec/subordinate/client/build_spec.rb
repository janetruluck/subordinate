# Build Spec
require "spec_helper"

describe Subordinate::Client do
  before(:each) do
    Subordinate.reset!
    Subordinate.configure do |c|
      c.subdomain = "jenkins"
      c.domain    = "example.com"
      c.port      = 8080
      c.ssl       = false
    end
  end

  let(:subordinate) { Subordinate::Client.new(:username => "someusername", :api_token => "sometoken") }

  describe "#build" do
    before(:each) {stub_jenkins(:get, "/job/Some-Job/1/api/json", "build.json") }

    let(:current_response) { subordinate.build("Some-Job", 1) }

    it "returns the job response" do
      current_response.should_not be_nil
    end

    context "methods" do
      it "responds to .actions" do
        current_response.should respond_to(:actions)
      end

      it "responds to .artifacts" do
        current_response.should respond_to(:artifacts)
      end

      it "responds to .building" do
        current_response.should respond_to(:building)
      end

      it "responds to .description" do
        current_response.should respond_to(:description)
      end

      it "responds to .duration" do
        current_response.should respond_to(:duration)
      end

      it "responds to .estimatedDuration" do
        current_response.should respond_to(:estimatedDuration)
      end

      it "responds to .executor" do
        current_response.should respond_to(:executor)
      end

      it "responds to .fullDisplayName" do
        current_response.should respond_to(:fullDisplayName)
      end

      it "responds to .id" do
        current_response.should respond_to(:id)
      end

      it "responds to .keepLog" do
        current_response.should respond_to(:keepLog)
      end

      it "responds to .number" do
        current_response.should respond_to(:number)
      end

      it "responds to .result" do
        current_response.should respond_to(:result)
      end

      it "responds to .timestamp" do
        current_response.should respond_to(:timestamp)
      end

      it "responds to .url" do
        current_response.should respond_to(:url)
      end

      it "responds to .builtOn" do
        current_response.should respond_to(:builtOn)
      end

      it "responds to .changeSet" do
        current_response.should respond_to(:changeSet)
      end

      it "responds to .culprits" do
        current_response.should respond_to(:culprits)
      end
    end
  end

  describe "#build_timestamp" do
    it "returns the timestamp of the specified build" do
      stub_jenkins(:get, "/job/Some-Job/1/buildTimestamp", 302, "text/plain", "build_timestamp.txt")

      subordinate.build_timestamp("Some-Job", 1).should == "9/9/13 9:32 PM"
    end

    it "returns the timestamp in the specified format" do
      stub_jenkins(:get, "/job/Some-Job/1/buildTimestamp?format=yyyy/MM/dd", 302, "text/plain", "build_timestamp_formatted.txt")

      subordinate.build_timestamp("Some-Job", 1, "yyyy/MM/dd").should == "2013/03/25"
    end
  end

  describe "#console_output_for_build" do
    context "complete console output" do
      before(:each) { stub_jenkins(:get, "/job/Some-Job/1/logText/progressiveText?start=0", 200, "text/plain", "console_output.txt") }
      let(:response) { subordinate.console_output_for_build("Some-Job", 1) }
      
      it "returns the console output for a complete build" do
        response.should_not be_nil
      end

      it "is not an error" do
        response.should_not include("javax.servlet.ServletException:")
      end
    end

    context "preformatted console output" do
      before(:each) { stub_jenkins(:get, "/job/Some-Job/1/logText/progressiveHtml?start=0", 200, "text/html", "console_output_pre.html") }
      let(:response) { subordinate.console_output_for_build("Some-Job", 1, nil, true) }
      
      it "returns the console output for a complete build" do
        response.should_not be_nil
      end

      it "is not an error" do
        response.should_not include("javax.servlet.ServletException:")
      end
    end

    context "offset console output" do
      before(:each) { 
        stub_jenkins(:get, "/job/Some-Job/1/logText/progressiveText?start=0", 200, "text/plain", "console_output.txt") 
        stub_jenkins(:get, "/job/Some-Job/1/logText/progressiveText?start=2000", 200, "text/plain", "console_output_offset.txt") 
      }
      let(:output1) {subordinate.console_output_for_build("Some-Job", 1, 2000) }
      let(:output2) {subordinate.console_output_for_build("Some-Job", 1, 0) }

      it "returns data at byte 2000" do
        output1.should_not be_nil
      end

      it "when passed an offset of 2000 it is offset by 2000 bytes" do
        output1.bytesize.should < output2.bytesize
      end
    end
  end
end
