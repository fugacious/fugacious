source 'https://rubygems.org'
git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

ruby '~> 2.4.2'

gem 'autoprefixer-rails'
gem 'coffee-rails', '~> 4.0.0'
gem 'dotenv-rails'
gem 'jbuilder', '~> 2.0'
gem 'rails', '~> 4.2'
gem 'sass-rails'
gem 'secure_headers'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'simple_form'
gem 'slim-rails', require: ['slim-rails', 'slim/translator']
gem 'thin'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'
gem 'uswds-rails', github: '18F/uswds-rails-gem'

group :test do
  gem 'capybara', '~> 2.3.0'
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem 'faker'
  gem 'launchy'
  gem 'poltergeist'
  gem 'rspec-collection_matchers'
  gem 'rspec-html-matchers'
  gem 'shoulda'
  gem 'timecop'
  gem 'webmock'
end

group :development, :test do
  gem 'brakeman', require: false
  gem 'coveralls', require: false
  gem 'factory_girl_rails'
  gem 'inch', require: false
  gem 'pry-nav'
  gem 'rspec-rails', '~> 3.1.0'
  gem 'sqlite3'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'quiet_assets'
  gem 'rb-fsevent'
  gem 'sinatra'
  gem 'unf'
end

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

group :production do
  gem 'pg'
  gem 'puma'
  gem 'rails_12factor'
end
