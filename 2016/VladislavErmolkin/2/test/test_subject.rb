require "minitest/autorun"
require_relative "../lib/subject"
require_relative "../lib/user"
require_relative "../lib/reset"

# Tests for class Subject.
class SubjectTest < Minitest::Test
  def setup
    REDIS.del("user_1")
  end

  def test_subject_correct_1
    assert_equal "OK", generate_labs("math", 3.to_s)
  end

  def test_subject_correct_2
    assert_equal "How many labs?", generate_subject("math")
  end

  def test_subject_incorrect_1
    assert_equal "How many labs?", generate_labs("math", -1.to_s)
  end

  def test_subject_incorrect_2
    assert_equal "How many labs?", generate_labs("math", 0.to_s)
  end

  def test_subject_incorrect_3
    assert_equal "How many labs?", generate_labs("math", 30.to_s)
  end

  def test_subject_incorrect_4
    assert_equal "Which subject?", generate_subject("/math")
  end

  def generate_subject(subject)
    Reset.new(User.new(1), "").run
    Subject.new(User.new(1), "/subject").run
    Subject.new(User.new(1), subject).run
  end

  def generate_labs(subject, number_of_labs)
    Reset.new(User.new(1), "").run
    Subject.new(User.new(1), "/subject").run
    Subject.new(User.new(1), subject).run
    Subject.new(User.new(1), number_of_labs).run
  end
end
