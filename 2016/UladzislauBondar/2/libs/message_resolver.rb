require_relative "command"
require_relative "start"
require_relative "semester"
require_relative "subject"
require_relative "status"
require_relative "reset"
include Command

# Resolves commands and messages from user
class MessageResolver
  COMMANDS = [
    Start,
    Semester,
    Subject,
    Status,
    Reset
  ].freeze

  def initialize(message)
    @message = message
    @redis ||= Redis.new
  end

  def resolve
    save_user unless users.include?(user_id)
    process_command
  end

  private

  def process_command
    if !(command = return_command).nil?
      save_user_command(text)
      command.new(@message).process
    else
      process_text
    end
  end

  def process_text
    case user_command
    when '/semester'
      process_semester
    when '/subject'
      process_subject
    else
      Undefined.new(@message).process
    end
  end

  def process_semester
    Semester.new(@message).process_semester_end
  end

  def process_subject
    command = Subject
    if command.subject_entered
      command.new(@message).process_quantity_of_works
    else
      command.new(@message).process_subject
    end
  end

  def return_command
    COMMANDS.each do |command_class|
      return command_class if command_class.name == text
    end
    nil
  end

  def text
    @message[:text]
  end

  def user_id
    @message[:from][:id].to_s
  end

  def users
    @redis.smembers("users")
  end

  def save_user
    @redis.sadd("users", user_id)
    set_user_command
    create_hash_of_subjects
  end

  def user_command
    @redis.hget("users_commands", user_id)
  end

  def create_hash_of_subjects
    @redis.hset("users_subjects", user_id, {})
  end

  def save_user_command(command = '')
    @redis.hset("users_commands", user_id, command)
  end
end
