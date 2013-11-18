require 'spec_helper'

describe Marketer::Campaign do
  describe ".count" do
    pending
  end

  describe ".configuration_manifest" do
    pending
  end

  describe ".available_campaign_ids" do
    pending
  end

  describe ".random_campaign_id" do
    pending
  end

  describe "#create_campaign_id_in_mailgun!" do
    subject { Marketer::Campaign.new(campaign_id).create_campaign_id_in_mailgun! }

    context "when either the campaign name or ID are too long" do
      pending
    end

    context "when length restrictions are met" do
      it 'should post to Mailgun' do
        pending 'vcr'
      end
    end
  end

  describe "#send_to!" do
    before do
      ResqueSpec.reset!
      Marketer::Campaign.stub(:configuration_manifest) do
        {
            "campaign_1" => {
                "campaign_name" => "Test Campaign Name"
            }
        }
      end
    end
    subject { Marketer::Campaign.new("campaign_1").send_to!(emails) }

    context "when emails are provided" do
      let(:emails) { ['a', 'b', 'c'] }

      it 'should enqueue 3 e-mails' do
        subject
        Marketer::SendCampaignJob.should have_queue_size_of(3)
      end
    end

    context 'when no emails are provided' do
      let(:emails) { [] }
      it 'should not enqueue any e-mails' do
        Marketer::SendCampaignJob.should have_queue_size_of(0)
      end
    end

  end

  describe "#details" do
    before do
      Marketer::Campaign.stub(:configuration_manifest) do
        {
          "campaign_1" => {
            "campaign_name" => "Test Campaign Name"
          },
          "campaign_2" => {
            "campaign_name" => "Test Campaign 2"
          }
        }
      end
    end

    subject { Marketer::Campaign.new(campaign_id).details }

    context "when a campaign is configured in the YAML file" do
      let(:campaign_id) { "campaign_1" }
      it { should be_a Hash }

      its(:keys) { should include "campaign_name" }
    end

    context "when a campaign is not configured in the YAML file" do
      let(:campaign_id) { "campaign_3" }
      it 'should raise an exception' do
        expect { subject }.to raise_exception
      end
    end
  end

  describe "configuration fetchers" do
    before do
      Marketer::Campaign.any_instance.stub(:details) do
        {
          "campaign_name" => "Test Campaign Name",
          "subject" => "Test Email Subject",
          "body" => "Test Email Body",
          "from" => "John <john@doe.com>"
        }
      end
    end

    describe "#name" do
      subject { Marketer::Campaign.new("campaign_1").name }
      it { should == "Test Campaign Name" }
    end

    describe "#subject" do
      subject { Marketer::Campaign.new("campaign_1").subject }
      it { should == "Test Email Subject" }
    end

    describe "#body" do
      subject { Marketer::Campaign.new("campaign_1").body }
      it { should == "Test Email Body" }
    end

    describe "#from" do
      subject { Marketer::Campaign.new("campaign_1").from }
      it { should == "John <john@doe.com>" }
    end
  end
end
