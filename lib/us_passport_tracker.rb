require 'us_passport_tracker/version'
require 'selenium-webdriver'
require 'uri'
require 'cgi'

module USPassportTracker

  # Core Implementations
  class Track
    TRACKER_URL = 'http://cgifederal.force.com/passporttracker'.freeze
    PASSPORT_INPUT = 'passportTrackerPage:psptTrackerForm:j_id34:j_id35:passportNo'.freeze
    ACTION_BUTTON = 'passportTrackerPage:psptTrackerForm:trackButton'.freeze
    OPTIONS = %w[headless window-size=250,150].freeze
    CHROME_OPTIONS = Selenium::WebDriver::Chrome::Options.new(args: OPTIONS)

    attr_accessor :country_code,
                  :country_name,
                  :passport_number,
                  :response_text,
                  :screenshot_enabled,
                  :screenshot_filename,
                  :root_url

    def initialize(passport_number,
                   country_code = 'GH',
                   screenshot_enabled = false,
                   screenshot_filename = 'PassportTrackerScreenshot')

      @passport_number = passport_number
      @country_code = country_code.downcase
      @country_name = nil
      @response_text = nil
      @screenshot_enabled = screenshot_enabled
      @screenshot_filename = screenshot_filename

      @driver = Selenium::WebDriver.for(:chrome, options: CHROME_OPTIONS)
      @root_url = "http://www.ustraveldocs.com/#{@country_code}/index.html?firstTime=No"
    end

    def status
      @driver.navigate.to @root_url
      @driver.get "#{TRACKER_URL}?country=#{uri_country_name}&language=en"
      @driver.find_element(id: PASSPORT_INPUT).send_keys(@passport_number)
      @driver.find_element(id: ACTION_BUTTON).click
      sleep 2 # Wait for Result to show
      take_screenshot if @screenshot_enabled
      @response_text = @driver.find_element(class: 'result').text
      stop_driver
      @response_text
    end

    private

    def uri_country_name
      uri = URI(@driver.find_element(id: 'login').attribute('href'))
      params = CGI.parse(uri.query)
      @country_name = CGI.unescape(params['country'].first)
      params['country'].first
    end

    def stop_driver
      @driver.quit
    end

    def take_screenshot
      @driver.save_screenshot "#{@screenshot_filename}.png"
    end
  end
end
