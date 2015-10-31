require File.expand_path("../../../config/environment", __FILE__)
ENV["RAILS_ENV"] ||= 'test'
require 'capybara'
require 'headless'
require 'cucumber/rails'
require 'selenium-webdriver'

Capybara.register_driver :selenium_chrome do |app|
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.timeout = 30
  Capybara::Selenium::Driver.new(app, :browser => :chrome, :http_client => client)
end
Capybara.javascript_driver = :selenium_chrome

After do |scenario|
  if scenario.failed?
    FileUtils.mkdir_p(File.join(Rails.root, 'tmp', 'capybara'))
      File.open(File.join(Rails.root, 'tmp', 'capybara', "fail.html"), 'w+') do |f|
      f.write page.body
    end
  end
  Rails.cache.clear
  Capybara.reset_sessions!
end
