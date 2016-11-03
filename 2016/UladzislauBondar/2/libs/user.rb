# Stores commands for a particcular user
class User
  def initialize(user_id)
    @id = user_id
    @redis = Redis.new
  end

  def command
    @redis.hget("commands", @id)
  end

  def subjects
    @redis.hget("subjects", @id)
  end

  def semester_step
    @redis.hget("semester_step", @id).to_i
  end

  def subject_step
    @redis.hget("subject_step", @id).to_i
  end

  def semester_start
    @redis.hget("semester_start", @id)
  end

  def semester_end
    @redis.hget("semester_end", @id)
  end

  def save_command(command = "")
    @redis.hset("commands", @id, command)
  end

  def create_hash_of_subjects
    @redis.hset("subjects", @id, {})
  end

  def save_semester_end(date)
    @redis.hset("semester_end", @id, date)
  end

  def save_semester_start(date)
    @redis.hset("semester_start", @id, date)
  end

  def save_semester_step(step)
    @redis.hset("semester_step", @id, step)
  end

  def save_subject_step(step)
    @redis.hset("subject_step", @id, step)
  end

  def save_subjects(hash)
    @redis.hset("subjects", @id, hash.to_json)
  end

  def delete_semester
    @redis.del("semester_end", @id)
  end

  def clear_subjects
    @redis.del("subjects", @id)
    @redis.hset("subjects", @id, {})
  end
end
