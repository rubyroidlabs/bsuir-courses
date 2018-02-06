require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
module ActiveSupport
  class TestCase
    fixtures :all
  end
  # Add more helper methods to be used by all tests here...
end
