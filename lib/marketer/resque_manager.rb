module Marketer
  class ResqueManager
    class << self
      attr_accessor :configured

      def enqueue(job, *args)
        resque.enqueue(job, *args)
      end

      def resque(options = {})
        unless self.configured
          configure_with_parameters({
              host: options[:host] || 'localhost'
          })
        end
        Resque
      end

      def configure_with_parameters(params)
        Resque.redis = ::Redis.new(params)
        self.configured = true
      end

      def reset!
        self.configured = false
      end
    end
  end
end
