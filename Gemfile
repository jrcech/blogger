source "https://rubygems.org"

ruby "3.3.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1', '>= 7.1.3.3'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Added

gem 'faker', '~> 3.3', '>= 3.3.1'
gem 'gretel', '~> 5.0'
gem 'kamal', '~> 1.5', '>= 1.5.2'
gem 'oj', '~> 3.16', '>= 3.16.3'
gem 'pagy', '~> 8.3'
gem 'seedbank', '~> 0.5.0'
gem 'slim-rails', '~> 3.6', '>= 3.6.3'
gem 'view_component', '~> 3.12', '>= 3.12.1'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]

  # Added

  # Debugging tools
  gem 'amazing_print', '~> 1.6', require: false
  gem 'bullet', '~> 7.1', '>= 7.1.6'

  # Test framework
  gem 'rspec-rails', '~> 6.1', '>= 6.1.2'

  # Test tools
  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.3'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Added

  gem 'annotate', '~> 3.2'
  gem 'better_errors', '~> 2.10', '>= 2.10.1'
  gem 'binding_of_caller', '~> 1.0', '>= 1.0.1'
  gem 'letter_opener', '~> 1.10'

  # Run all static code quality analysis tools with Git hooks on every commit
  gem 'overcommit', '~> 0.63.0', require: false

  # Static code quality analysis tools
  gem 'brakeman', '~> 6.1', '>= 6.1.2', require: false
  gem 'bundler-audit', '~> 0.9.1', require: false
  gem 'erb_lint', '~> 0.5.0', require: false
  gem 'fasterer', '~> 0.11.0', require: false
  gem 'flay', '~> 2.13', '>= 2.13.2', require: false
  gem 'reek', '~> 6.3', require: false
  gem 'rubocop-capybara', '~> 2.20', require: false
  gem 'rubocop-factory_bot', '~> 2.25', '>= 2.25.1', require: false
  gem 'rubocop-performance', '~> 1.21', require: false
  gem 'rubocop-rails', '~> 2.24', '>= 2.24.1', require: false
  gem 'rubocop-rspec', '~> 2.29', '>= 2.29.1', require: false
  gem 'rubycritic', '~> 4.9', require: false
end

# Added

group :test do
  gem 'capybara', '~> 3.40'
  gem 'capybara-email', '~> 3.0', '>= 3.0.2'
  gem 'selenium-webdriver', '~> 4.19'
  gem 'shoulda-matchers', '~> 6.2'
  gem 'simplecov', '~> 0.22.0', require: false
  gem 'timecop', '~> 0.9.8'
  gem 'vcr', '~> 6.2'
  gem 'webmock', '~> 3.23'
end
