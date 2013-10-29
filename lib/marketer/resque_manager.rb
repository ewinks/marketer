module Marketer
  class ResqueManager
    class << self
      attr_accessor :configured

      def enqueue(job, *args)
        resque.enqueue(job, *args)
      end

      def resque
        unless configured
          Resque.redis = ::Redis.new(
            host: 'localhost'
          )
          self.configured = true
        end
        Resque
      end
    end
  end
end
