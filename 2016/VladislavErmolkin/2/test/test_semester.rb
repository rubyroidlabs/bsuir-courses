require "minitest/autorun"
require_relative "../lib/semester"
require_relative "../lib/user"
require_relative "../lib/reset"

# Tests for class Semester.
class SemesterTest < Minitest::Test
  def setup
    REDIS.del("user_1")
  end

  def test_semester_correct
    assert_equal "2 Months, 3 Weeks and 4 Days", generate_difference(%w(2016 September 1), %w(2016 November 25))
  end

  def test_semester_incorrect_1
    assert_equal "Too big semester.", generate_difference(%w(2016 September 1), %w(2017 November 21))
  end

  def test_semester_incorrect_2
    assert_equal "Time travel? Incorrect time interval.", generate_difference(%w(2016 September 1), %w(2015 November 25))
  end

  def test_semester_incorrect_3
    assert_equal "You are not in semester. Sorry.", generate_difference(%w(2016 September 1), %w(2016 November 1))
  end

  def test_semester_incorrect_4
    assert_equal "You are not in semester. Sorry.", generate_difference(%w(2016 November 20), %w(2016 November 29))
  end

  def generate_difference(f_date, s_date)
    Reset.new(User.new(1), "").run
    generate_semester("/semester")
    f_date.each { |text| generate_semester(text) }
    s_date.each { |text| generate_semester(text) }
    Semester.new(User.new(1), "").bot_says
  end

  def generate_semester(text)
    Semester.new(User.new(1), text).run
  end
end
