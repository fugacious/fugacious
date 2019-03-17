require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'missing_translations_helper'
require 'factory_bot'
require 'shoulda/matchers'

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |file| require file }

if ENV['CI']
  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
else
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(SimpleCov::Formatter::HTMLFormatter)
end

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include FactoryBot::Syntax::Methods
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
