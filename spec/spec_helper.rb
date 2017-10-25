require 'coveralls'
require 'simplecov'
require 'webmock/rspec'

ENV['RAILS_ENV'] ||= 'test'

Coveralls.wear!('rails')
SimpleCov.start 'rails' do
  add_filter '/lib/rspec/formatters/user_flow_formatter.rb'
end

RSpec.configure do |config|
  config.order = :random
  WebMock.disable_net_connect!(allow: [/localhost/, /127\.0\.0\.1/, /codeclimate.com/])

  # Skip user_flow specs in default tasks
  config.filter_run_excluding user_flow: true
end
