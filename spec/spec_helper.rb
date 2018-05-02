require "bundler/setup"
require "us_passport_tracker"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) do
    @valid_passport = ENV['USPT_VALID_PASSPORT_ID']
    @valid_country_code = ENV['USPT_VALID_COUNTRY_CODE']

    @valid_country_invalid_embassy = 'JP'
    @invalid_passport = 'USPTRK001'

    @track = USPassportTracker::Track
  end
end
