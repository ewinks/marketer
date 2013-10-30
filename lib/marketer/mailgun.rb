require 'rest_client'

module Marketer
  class Mailgun
    def self.post!(endpoint, parameters, &block)
      RestClient.post("https://api:#{api_key}" \
                      "@api.mailgun.net/v2/#{domain}/#{endpoint}",
                      parameters,
                      &block)
    end

    private

    def self.configuration
      @@configuration ||= YAML.load_file("./data/credentials.yaml")["mailgun"]
    end

    def self.api_key
      configuration['api_key']
    end

    def self.domain
      configuration['domain']
    end

  end
end
