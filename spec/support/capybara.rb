# frozen_string_literal: true

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
  options.add_argument('--disable-gpu')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
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
    url: "http://#{selenium_driver}:4444/wd/hub",
    capabilities: options
  )
end

Capybara.register_driver :remote_selenium_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--disable-gpu')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1920,1080')

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: "http://#{selenium_driver}:4444/wd/hub",
    capabilities: options
  )
end

Capybara.configure do |config|
  config.server_host = Socket.ip_address_list.find(&:ipv4_private?).ip_address
  config.server_port = 4000
  config.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, js: true, type: :system) do
    locality = ENV['DOCKER'].present? ? 'remote' : 'local'
    headless = '_headless' if ENV['DISABLE_HEADLESS'].blank?

    driver = "#{locality}_selenium#{headless}".to_sym

    driven_by driver
  end

  config.after(:each, js: true, type: :system) do
    Capybara.reset_sessions!
  end
end

def selenium_driver
  drivers = %w[selenium-chrome seleniarm-chromium]

  ENV.fetch('COMPOSE_PROFILES', '').split(',').find do |profile|
    drivers.include?(profile)
  end
end