require "minitest/autorun"
require_relative "../lib/semester"
require_relative "../lib/user"
require_relative "../lib/reset"

# Tests for class Semester.
class SemesterTest < Minitest::Test
  def setup
    User.redis.del("user_1")
  end

  def test_semester_correct
    assert_equal "2 Months, 3 Weeks and 4 Days", generate_difference("2016", "September", "1", "2016", "November", "25")
  end

  def test_semester_incorrect_1
    assert_equal "Too big semester.", generate_difference("2016", "September", "1", "2018", "November", "25")
  end

  def test_semester_incorrect_2
    assert_equal "Time travel? Incorrect time interval.", generate_difference("2016", "September", "1", "2015", "November", "25")
  end

  def test_semester_incorrect_3
    assert_equal "You are not in semester. Sorry.", generate_difference("2016", "September", "1", "2016", "November", "1")
  end

  def test_semester_incorrect_4
    assert_equal "You are not in semester. Sorry.", generate_difference("2016", "November", "20", "2016", "November", "29")
  end

  def generate_difference(f_year, f_month, f_day, s_year, s_month, s_day)
    Reset.new(User.new(1), "").run
    Semester.new(User.new(1), "/semester").run
    Semester.new(User.new(1), f_year).run
    Semester.new(User.new(1), f_month).run
    Semester.new(User.new(1), f_day).run
    Semester.new(User.new(1), s_year).run
    Semester.new(User.new(1), s_month).run
    Semester.new(User.new(1), s_day).run
  end
end
