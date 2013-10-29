module Marketer
  class Sender
    def self.send_to!(email_list)
      email_list = Marketer::ListCleaner.clean_list(email_list.to_a)
      chunked_campaign_distribution(email_list).each do |campaign_mailgun_id, emails|
        Marketer::Campaign.new(campaign_mailgun_id).send_to!(emails)
      end
    end

    private

    def self.campaign_bucket_count(email_list)
      (email_list.count / Marketer::Campaign.count).round
    end

    def self.print_dry_run_details!(campaign_distribution, email_list)
      puts campaign_distribution.inspect
      puts "#{email_list.count} e-mails across #{Marketer::Campaign.count} campaigns."
      puts "Bucket counts:"
      campaign_distribution.each do |campaign_id, emails|
        puts "#{campaign_id}: #{emails.count}"
      end
    end

    def self.chunk_list(email_list)
      email_list.shuffle.each_slice(campaign_bucket_count(email_list))
    end

    def self.chunked_campaign_distribution(email_list)
      list = chunk_list(email_list)
      # 3. For each chunk, choose a campaign at random and assign it
      campaign_distribution = Hash.new { |h, k| h[k] = [] }
      list.each do |emails|
        campaign_id = Marketer::Campaign.random_campaign_id
        campaign_distribution[campaign_id] += emails.to_a
        campaign_distribution[campaign_id].flatten!
      end
      if ENV['DRY_RUN'] == 'true'
        print_dry_run_details!(campaign_distribution, email_list)
        exit 0
      end
      campaign_distribution
    end
  end

end
