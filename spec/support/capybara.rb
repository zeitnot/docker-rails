Capybara.register_driver :selenium_chrome_headless do |app|

  caps = Selenium::WebDriver::Remote::Capabilities
             .chrome(chromeOptions: { args: ['headless','disable-gpu'] })
  Capybara::Selenium::Driver.new(app, browser: :remote,
                                 url: 'http://selenium:4444/wd/hub',
                                 desired_capabilities: caps
  )
end