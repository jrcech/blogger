# frozen_string_literal: true

Capybara.server_port = 4000

Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--window-size=1920,1080')
  options.add_argument('--headless')

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: "http://selenium_chrome:4444/wd/hub",
    capabilities: options
  )
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless

    Capybara.server_host = '0.0.0.0'
    Capybara.server_port = 4000
    Capybara.app_host = 'http://web:4000'
  end
end
