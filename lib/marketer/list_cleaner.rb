require 'resolv'

module Marketer
  class ListCleaner
    def self.clean_list(email_list)
      email_list.uniq.reject {|email_address|
        !self.validate_email_domain(email_address)
      }
    end

    def self.validate_email_domain(email)
      domain = email.split("@").last
      Resolv::DNS.open do |dns|
        @mx = dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
      end
      @mx.size > 0 ? true : false
    end
  end
end
