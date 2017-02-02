source 'https://rubygems.org'
git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

gem 'autoprefixer-rails'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'dotenv-rails'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'rails', '~> 4.2.7.1'
gem 'sass-rails', '~> 4.0.3'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'secure_headers'
gem 'slim-rails', require: ['slim-rails', 'slim/translator']
gem 'therubyracer'
gem 'thin'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'quiet_assets'
  gem 'rb-fsevent'
  gem 'sinatra'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'unf'
end

group :devops do
  gem 'berkshelf'
  gem 'capistrano-rails'
  gem 'knife-ec2'
  gem 'knife-solo', github: 'matschaffer/knife-solo', submodules: true
  gem 'knife-solo_data_bag'
  gem 'rvm-capistrano'
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

group :test do
  gem 'capybara', '~> 2.3.0'
  gem 'capybara-screenshot'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'faker'
  gem 'launchy'
  gem 'rspec-collection_matchers'
  gem 'rspec-html-matchers'
  gem 'shoulda'
  gem 'timecop'
  gem 'webmock'
end

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

group :production do
  # Use postgresql as the database for Active Record
  gem 'pg'
  gem 'puma'
  gem 'rails_12factor'
end
