# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'rails', '~> 7.0.5'

gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'redis', '~> 4.0'

gem 'sprockets-rails'

gem 'cssbundling-rails'
gem 'jsbundling-rails'

gem 'stimulus-rails'
gem 'turbo-rails'

gem 'jbuilder'

gem 'bootsnap', require: false

group :development, :test do
  gem 'debug', '1.7.0', platforms: %i[mri mingw x64_mingw]
end

# Debugging
group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  gem 'web-console'
end

group :development, :test do
  gem 'amazing_print'
  gem 'bullet'
  gem 'pry-rails'
end

# Code Quality
group :development do
  gem 'overcommit'

  gem 'brakeman'
  gem 'bundler-audit'
  gem 'fasterer'
  gem 'flay'
  gem 'rails_best_practices'
  gem 'reek'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubycritic', require: false
  gem 'slim_lint'
end

# Testing
group :development, :test do
  gem 'rspec-rails'

  gem 'factory_bot_rails'
  gem 'faker'
end

group :test do
  gem 'capybara'
  gem 'capybara-email'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'w3c_validators'
  gem 'webdrivers', require: false
end

# Authentication
gem 'devise'

gem 'email_validator'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'rolify'

# Database
gem 'seedbank'

group :development do
  gem 'annotate'
  gem 'rails-erd'
end

# View
gem 'slim-rails'
gem 'view_component'

gem 'gretel'
gem 'oj'
gem 'pagy'
gem 'simple_form'

gem 'dotenv-rails'

gem 'sentry-rails'
gem 'sentry-ruby'
