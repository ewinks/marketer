module Marketer
  class Campaign
    attr_accessor :mailgun_id

    def initialize(mailgun_id)
      @mailgun_id = mailgun_id
    end

    def self.count
      available_campaign_ids.count
    end

    def self.available_campaign_ids
      @@available_campaign_ids ||= configuration_manifest.keys
      @@unused_campaign_ids ||= configuration_manifest.keys
      configuration_manifest.keys
    end

    def self.random_campaign_id
      campaign_id = @@unused_campaign_ids.shuffle.first || @@available_campaign_ids.shuffle.first
      @@unused_campaign_ids.delete(campaign_id)
      campaign_id
    end

    def create_campaign_id_in_mailgun!
      raise ArgumentError if name.length >= 64 || @mailgun_id.length >= 64

      Marketer::Mailgun.post!("campaigns", {
        name: @name,
        id: @mailgun_id
      })
    end

    def send_to!(email_list)
      email_list.each do |email_address|
        Marketer::ResqueManager.enqueue(Marketer::SendCampaignJob, email_address, subject, body, from, mailgun_id)
      end
    end

    def details
      @details ||= self.class.configuration_manifest[@mailgun_id]
      raise ArgumentError unless @details
      @details
    end

    def name
      details["campaign_name"]
    end

    def subject
      details["subject"]
    end

    def body
      details["body"]
    end

    def from
      details["from"]
    end

    private

    def self.configuration_manifest
      @@configuration_manifest ||= YAML.load_file("./data/campaigns.yaml")["campaigns"]
    end
  end
end
