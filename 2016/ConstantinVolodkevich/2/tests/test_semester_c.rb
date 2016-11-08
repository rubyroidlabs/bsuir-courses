require_relative '../commands/semester_c'
require 'test/unit'

class Test_Semester_C < Test::Unit::TestCase

  @@semester_c = Semester_C.new

  def test_save_ending_date_past_time_handle
    user = User.new('Jon', 'Snow')
    curr_time = Time.new
    curr_date = Date.parse curr_time.inspect
    past = (curr_date - 1).to_s
    user = @@semester_c.save_ending_date(user, past)
    assert_equal(false, user.user_status.steps_semester['got_ending_date'])
  end

  def test_save_ending_date_future_time_handle
    user = User.new('Jon', 'Snow')
    curr_time = Time.new
    curr_date = Date.parse curr_time.inspect
    future = (curr_date + 1).to_s
    user = @@semester_c.save_ending_date(user, future)
    assert_equal(true, user.user_status.steps_semester['got_ending_date'])
  end

  def test_save_ending_date_random_string_handle
    user = User.new('Jon', 'Snow')
    r_string = ('a'..'z').to_a.shuffle[0,8].join
    user = @@semester_c.save_ending_date(user, r_string)
    assert_equal('', user.semester.ending_date)
  end

end

