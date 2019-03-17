ENV['RAILS_ENV'] ||= 'test'

require 'coveralls'
require 'simplecov'
require 'webmock/rspec'

Coveralls.wear!('rails')

RSpec.configure do |config|
  config.order = :random
  WebMock.disable_net_connect!(allow: [/localhost/, /127\.0\.0\.1/, /codeclimate.com/])
end

SimpleCov.start 'rails'
