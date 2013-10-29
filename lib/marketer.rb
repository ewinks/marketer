$:.unshift File.dirname(__FILE__)

require 'marketer/list_generator'
require 'marketer/list_cleaner'
require 'marketer/mailgun'
require 'marketer/campaign'
require 'marketer/send_campaign_job'
require 'marketer/sender'
require 'marketer/resque_manager'

require 'pry'

