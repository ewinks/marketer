require './lib/marketer'
require 'resque'
require 'pry'

require 'webmock/rspec'
require 'resque_spec'


WebMock.enable!
ResqueSpec.reset!

RSpec.configure do |config|

end