if Capybara.current_driver == :selenium_chrome
  require 'headless'

  headless = Headless.new
  headless.start

  at_exit do
    headless.destroy
  end
end
