source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.7.1'

gem 'autoprefixer-rails'
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'dotenv-rails'

gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'slim-rails', require: ['slim-rails', 'slim/translator']
gem 'thin'
gem 'secure_headers'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'simple_form'
gem 'uswds-rails', github: '18F/uswds-rails-gem'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'quiet_assets'
  gem 'rb-fsevent'
  gem 'unf'
  gem 'sinatra'
end

group :devops do
  gem 'capistrano-rails'
  gem 'berkshelf'
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
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'faker'
  gem 'launchy'
  gem 'rspec-collection_matchers'
  gem 'rspec-html-matchers'
  gem 'shoulda'
  gem 'webmock'
  gem 'timecop'

end

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

group :production do
  # Use postgresql as the database for Active Record
  gem 'pg'
  gem 'puma'
  gem 'rails_12factor'
end
