require_relative '../models/semester'
require 'test/unit'

class Test_Semester < Test::Unit::TestCase
  @@semester = Semester.new

  def test_time_left_days
    curr_time = Time.new
    curr_date = Date.parse curr_time.inspect
    future = curr_date + 2
    assert_equal('Got it! You got 2 days left!', @@semester.time_left(future))
  end

  def test_time_left_month
    curr_time = Time.new
    curr_date = Date.parse curr_time.inspect
    future = curr_date + 32
    assert_equal('Got it! You got 1 months and 2 days left!', @@semester.time_left(future))
  end
end
