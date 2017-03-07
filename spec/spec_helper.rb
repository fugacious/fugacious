require 'simplecov'
require 'coveralls'

Coveralls.wear!('rails')
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'

require 'webmock/rspec'

RSpec.configure do |config|
  config.order = :random
  WebMock.disable_net_connect!(allow: [/localhost/, /127\.0\.0\.1/, /codeclimate.com/])
end
