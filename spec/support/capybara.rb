require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist

Capybara.asset_host = ENV['RAILS_ASSET_HOST'] || 'http://localhost:3000'
