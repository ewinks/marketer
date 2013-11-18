module Marketer
  class SendCampaignJob
    @queue = :marketing_email

    RANDOMNESS_RANGE = (1..20).to_a

    def self.perform(email, subject, text, from_email, campaign_id, should_sleep = true)
      sleep RANDOMNESS_RANGE.sample if should_sleep

      send!(email_parameters(email, subject, text, html, from_email, campaign_id))
    end

    private

    def self.email_parameters(email, subject, text, html, from_email, campaign_id)
      {
        to: email,
        subject: subject,
        text: text,
        html: html,
        from: from_email,
        'o:campaign' => campaign_id,
      }
    end

    def self.send!(parameters)
      Marketer::Mailgun.post!("messages", parameters)
    end
  end
end
