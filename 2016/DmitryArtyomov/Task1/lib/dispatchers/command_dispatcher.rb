# Class for dispatching all commands
class CommandDispatcher
  AVAILABLE_COMMANDS = [
    BotCommand::Start,
    BotCommand::Status,
    BotCommand::Cancel,
    BotCommand::Semester,
    BotCommand::SubjectDelete,
    BotCommand::Subject,
    BotCommand::Submit,
    BotCommand::Reset,    
    BotCommand::Undefined
  ].freeze

  def initialize(message, message_handler, action_handler)
    @message = message
    @message_handler = message_handler
    @action_handler = action_handler
    dispatch
  end

  private

  attr_reader :message, :message_handler, :action_handler

  def dispatch
    command = AVAILABLE_COMMANDS.find do |cmd|
      cmd.new(message, message_handler, action_handler).should_start?
    end
    command.new(message, message_handler, action_handler).start if command
  end
end
