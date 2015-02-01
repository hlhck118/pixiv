ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
require 'capybara/rails'

Minitest::Reporters.use!(
    Minitest::Reporters::SpecReporter.new,
    ENV,
    Minitest.backtrace_filter
)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include Capybara::DSL
  include FactoryGirl

  include Warden::Test::Helpers
  Warden.test_mode!

  ActiveRecord::Migration.check_pending!

  Capybara.default_driver = :selenium
  def teardown
    Capybara.reset_sessions!
  end
end
