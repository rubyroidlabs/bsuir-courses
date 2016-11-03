require_relative "user"
require_relative "command"
require_relative "start"
require_relative "semester"
require_relative "subject"
require_relative "status"
require_relative "reset"
require_relative "undefined"

# Resolves commands and messages from user
class MessageResolver
  COMMANDS = [
    Command::Start,
    Command::Semester,
    Command::Subject,
    Command::Status,
    Command::Reset
  ].freeze

  def initialize(message)
    @message = message
    @redis = Redis.new
    @user = User.new(user_id)
  end

  def resolve
    save_user unless users.include?(user_id)
    process_command
  end

  private

  def process_command
    if (command = resolve_command).nil?
      process_text
    else
      @user.save_command(text)
      command.new(@message).process
    end
  end

  def process_text
    case @user.command
    when "/semester"
      process_semester
    when "/subject"
      process_subject
    else
      Command::Undefined.new(@message).process
    end
  end

  def process_semester
    semester = Command::Semester
    case @user.semester_step
    when semester::START
      semester.new(@message).process_semester_start
    when semester::FINISH
      semester.new(@message).process_semester_end
    end
  end

  def process_subject
    subject = Command::Subject
    case @user.subject_step
    when subject::NAME
      subject.new(@message).process_subject
    when subject::WORKS
      subject.new(@message).process_quantity_of_works
    end
  end

  def resolve_command
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
    @user.save_command
    @user.create_hash_of_subjects
  end
end
