# Class that handle each command which is entered by user
class BotCommandHandler
  COMMANDS = [
    BotCommandStart,
    BotCommandSemester,
    BotCommandSubject,
    BotCommandStatus,
    BotCommandSubmit,
    BotCommandReset
  ].freeze

  def process(update)
    COMMANDS.each do |command|
      c = command.new(update)
      if c.called?
        c.perform
        return
      end
    end
  end
end
