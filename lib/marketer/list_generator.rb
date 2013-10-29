require 'csv'

module Marketer
  class ListGenerator
    def self.list_from_csv(file_path)
      ::Enumerator.new do |y|
        CSV.foreach(file_path) do |row|
          y.yield row[0]
        end
      end
    end
  end
end
