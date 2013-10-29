module Marketer
  class ListCleaner
    def self.clean_list(email_list)
      email_list.uniq
    end
  end
end
