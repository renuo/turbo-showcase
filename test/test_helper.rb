ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

# Some actions call `sleep` to simulate slow responses. Skip those delays in tests.
module SkipSimulatedDelays
  private

  def sleep(_duration)
  end
end
ApplicationController.prepend(SkipSimulatedDelays)

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
