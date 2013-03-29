require "spec_helper"



# Client Spec
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

  describe "#build", :vcr do
    let(:current_response) { subordinate.build(ENV["JOB"], 1) }

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
      stub_request(:get, "#{subordinate.api_endpoint}/job/#{ENV["JOB"]}/1/buildTimestamp").
      to_return(:status => 302, :body => "3/25/13 3:30 AM", :headers => {})


      subordinate.build_timestamp(ENV["JOB"], 1).should == "3/25/13 3:30 AM"
    end

    it "returns the timestamp in the specified format" do
      stub_request(:get, "#{subordinate.api_endpoint}/job/#{ENV["JOB"]}/1/buildTimestamp?format=yyyy/MM/dd").
      to_return(:status => 302, :body => "2013/03/25", :headers => {})

      subordinate.build_timestamp(ENV["JOB"], 1, "yyyy/MM/dd").should == "2013/03/25"
    end
  end

  describe "#console_output_for_build", :vcr do
    it "returns the console output for a complete build" do
      response = subordinate.console_output_for_build(ENV["JOB"], 1)
      response.should_not be_nil
      response.should_not include("javax.servlet.ServletException:")
    end

    it "returns pre-formatted output" do
      response = subordinate.console_output_for_build(ENV["JOB"], 1, nil, true)
      response.should_not be_nil
      response.should_not include("javax.servlet.ServletException:")
    end

    context "byte size arguement" do
      it "returns data at byte 2000" do
        subordinate.console_output_for_build(ENV["JOB"], 1, 2000).should_not be_nil
      end

      it "when passed an offset of 2000 it is offset by 2000 bytes" do
        output1 = subordinate.console_output_for_build(ENV["JOB"], 1, 2000)
        output2 = subordinate.console_output_for_build(ENV["JOB"], 1, 0)

        output1.bytesize.should < output2.bytesize
      end
    end
  end
end