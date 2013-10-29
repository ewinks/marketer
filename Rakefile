require 'rake'
require 'rubygems'
require 'bundler'

Bundler.setup(:default, :test)

require 'resque/tasks'
require './lib/marketer'

task :run do
  Marketer::Sender.send_to!(Marketer::ListGenerator.list_from_csv("./data/emails.csv"))
end
