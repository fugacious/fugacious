source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.7.1'

gem 'autoprefixer-rails'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'dotenv-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'secure_headers'
gem 'slim-rails', require: ['slim-rails', 'slim/translator']
gem 'therubyracer'
gem 'thin'
gem 'whenever'
gem 'sidekiq'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'quiet_assets'
  gem 'rb-fsevent'
  gem 'spring'
  gem 'spring-commands-rspec'
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
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'faker'
  gem 'launchy'
  gem 'rspec-collection_matchers'
  gem 'rspec-html-matchers'
  gem 'shoulda'
  gem 'webmock'
  gem 'timecop'
  gem 'shoulda-whenever', '~> 0.0.1'

end

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

group :production do
  # Use postgresql as the database for Active Record
  gem 'pg'
  gem 'puma'
  gem 'rails_12factor'
  gem 'cf-app-utils'
end
