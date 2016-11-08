require "test/unit"
require "time_diff"
require_relative "lib/friendly_date"
require_relative "lib/exceptions"

class TestFriendlyDate < Test::Unit::TestCase
  def test_friendly_date_failure
    assert_raise(DateFormatError) { FriendlyDate.new("asf.asf.a") }
    assert_raise(DateFormatError) { FriendlyDate.new("10.13.2015") }
    assert_raise(DateFormatError) { FriendlyDate.new("35.12.2010") }
    assert_raise(DateFormatError) { FriendlyDate.new("30.02.2016") }
    assert_raise(DateFormatError) { FriendlyDate.new("15,01,2017") }
    assert_raise(DateFormatError) { FriendlyDate.new("2015") }
    assert_raise(DateFormatError) { FriendlyDate.new("1.01") }
  end

  def test_friendly_date_succeed
    assert_nothing_raised { FriendlyDate.new("01.01.2015") }
    assert_nothing_raised { FriendlyDate.new("1.01.2015") }
    assert_nothing_raised { FriendlyDate.new("01.1.2015") }
    assert_nothing_raised { FriendlyDate.new("1.1.2015") }
    assert_nothing_raised { FriendlyDate.new("01.01.15") }
    assert_nothing_raised { FriendlyDate.new("1.01.15") }
    assert_nothing_raised { FriendlyDate.new("01.1.15") }
    assert_nothing_raised { FriendlyDate.new("1.1.15") }
  end
end