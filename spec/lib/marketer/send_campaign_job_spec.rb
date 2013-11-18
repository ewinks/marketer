require 'spec_helper'

describe Marketer::SendCampaignJob do
  describe ".perform" do
    subject { Marketer::SendCampaignJob.perform(email, email_subject, text, from, campaign_id, false) }
    let(:email) { "test@test.com" }
    let(:email_subject) { "Test Subject" }
    let(:text) { "Test text" }
    let(:from) { "tester@test.com" }
    let(:campaign_id) { 1 }
    before do
      Marketer::Mailgun.should_receive(:post!).with("messages", {
          to: email,
          subject: email_subject,
          text: text,
          from: from,
          'o:campaign' => campaign_id
      })
    end

    it 'should ask Mailgun to send an email with appropriate parameters' do
      subject
    end
  end
end
