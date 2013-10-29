module Marketer
  class SendCampaignJob
    @queue = :marketing_email

    RANDOMNESS_RANGE = (1..10).to_a

    def self.perform(email, subject, text, from_email, campaign_id)
      sleep RANDOMNESS_RANGE.sample

      send!(email_parameters(email, subject, text, from_email, campaign_id))
    end

    private

    def self.email_parameters(email, subject, text, from_email, campaign_id)
      {
        to: email,
        subject: subject,
        text: text,
        from: from_email,
        'o:campaign' => campaign_id
      }
    end

    def self.send!(parameters)
      Marketer::Mailgun.post!("messages", parameters)
    end
  end
end
