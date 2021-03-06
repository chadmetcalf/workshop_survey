# frozen_string_literal: true
source 'https://rubygems.org'

# TODO: https://hackernoon.com/how-to-setup-and-deploy-a-rails-5-app-on-aws-beanstalk-with-postgresql-redis-and-more-88a38355f1ea#.fzw1ll3nt

ruby '2.4.1'

gem 'autoprefixer-rails'
gem 'awesome_print'
gem 'clearance'
gem 'coffee-script'
gem 'distribution'
gem 'flutie'
gem 'jquery-rails'
gem 'kaminari'
gem 'normalize-rails', '~> 3.0.0'
gem 'oj'
gem 'pg'
# gem 'postmark-rails'
gem 'puma'
gem 'rack-canonical-host'
gem 'rails', '5.1.1'
gem 'rails_semantic_logger'
gem 'recipient_interceptor'
gem 'rollbar'
gem 'sass-rails', '~> 5.0'
gem 'sidekiq'
gem 'simple_form'
gem 'skylight'
gem 'sprockets', '>= 3.0.0'
gem 'suspenders'
gem 'title'
gem 'uglifier'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'listen'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'web-console'

  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rubocop'
  gem 'guard-rspec'
end

group :development, :test do
  gem 'bullet'
  gem 'bundler-audit', '>= 0.5.0', require: false
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.5'
end

group :development, :staging do
  gem 'rack-mini-profiler'
end

group :test do
  gem 'faker'
  gem 'database_cleaner'
  gem 'formulaic'
  gem 'launchy'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'webmock'
end

group :staging, :production do
  gem 'rack-timeout'
end

gem 'high_voltage'
