require_relative "bot_command"
require_relative "user"

# dispatch valid command
class BotMessageDispatcher
  attr_reader :message, :user
  AVAILABLE_COMMANDS = [
    BotCommand::Start,
    BotCommand::Semester,
    BotCommand::Subject,
    BotCommand::Submit,
    BotCommand::Status,
    BotCommand::Reset
  ].freeze

  def initialize(message, user)
    @message = message
    @user = user
  end

  def process
    command = parse_command
    if command
      command.new(@user, @message).start
    elsif next_command_exist?
      execute_next_command_method(@user.next_bot_command[:method])
    else
      BotCommand::Undefined.new(@user, @message).start
    end && user.save
  end

  protected

  def parse_command
    AVAILABLE_COMMANDS.detect { |command_class| command_class.new(@user, @message).should_start? }
  end

  def next_command_exist?
    @user.next_bot_command[:class]
  end

  def execute_next_command_method(method)
    @user.next_bot_command[:class].new(@user, @message).public_send method
  end
end
