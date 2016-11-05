require_relative '../controllers/db_helper'
require 'test/unit'


class Test_DB_Helper < Test::Unit::TestCase

  def eq?(user1, user2)
    user1.status == user2.status && user1.name == user2.name && user1.last_name == user2.last_name &&
    user1.user_status.steps_semester == user2.user_status.steps_semester &&
    user1.user_status.steps_subject == user2.user_status.steps_subject &&
    user1.user_status.steps_submit == user2.user_status.steps_submit &&
    user1.user_status.steps_reset == user2.user_status.steps_reset &&
    user1.user_status.steps_reminder == user2.user_status.steps_reminder
  end

  def test_from_json
    db = DB_Helper.new
    user = User.new('A', 'B')
    db.redis.set "2", db.to_json(user)
    assert_equal(true, eq?(user, db.get_user("2")))
  end
end
