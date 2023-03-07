# frozen_string_literal: true

selenium_app_host = ENV.fetch('SELENIUM_APP_HOST') do
  Socket.ip_address_list.find(&:ipv4_private?).ip_address
end

Capybara.configure do |config|
  config.server_host = selenium_app_host
  config.server_port = 4000
end

Capybara.register_driver :local_selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--window-size=1920,1080')

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options:
  )
end

Capybara.register_driver :local_selenium_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--window-size=1920,1080')

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options:
  )
end

Capybara.register_driver :remote_selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--window-size=1920,1080')

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: "http://#{Rails.application.credentials.selenium[:host]}:4444/wd/hub",
    capabilities: options
  )
end

Capybara.register_driver :remote_selenium_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--window-size=1920,1080')

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: "http://#{Rails.application.credentials.selenium[:host]}:4444/wd/hub",
    capabilities: options
  )
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, js: true, type: :system) do
    Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"

    locality = ENV['SELENIUM_HOST'].present? ? :remote : :local
    headless = '_headless' if ENV['DISABLE_HEADLESS'].blank?

    "#{locality}_selenium#{headless}".to_sym

    driven_by "#{locality}_selenium#{headless}".to_sym
  end
end
