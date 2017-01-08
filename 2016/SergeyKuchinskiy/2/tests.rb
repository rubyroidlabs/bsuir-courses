require "test/unit"
require_relative "lib/bot"
require_relative "lib/subject_bot"

# Tests
class TestFriendlyDate < Test::Unit::TestCase
  def test_subject_stop
    assert_equal true, SubjectBot.new("test", Message_for_tests.new("/stop")).stop_input?({})
  end

  def test_subject_first_stage
    assert_equal "/subject/save_labs", SubjectBot.new("test", Message_for_tests.new("SUBJECT")).first_stage({})
  end

  def test_subject_first_stage_2
    assert_equal "/subject/save_subject", SubjectBot.new("test", Message_for_tests.new("/SUBJECT")).first_stage({})
  end

  def test_subject_second_stage
    assert_equal "/subject/save_labs", SubjectBot.new("test", Message_for_tests.new("sfsd")).second_stage({})
  end

  def test_subject_second_stage_2
    assert_equal nil, SubjectBot.new("test", Message_for_tests.new("1")).second_stage({})
  end
end

# imitation of class message
class MessageForTests
  attr_accessor :text

  def initialize(text)
    @text = text
  end
end
