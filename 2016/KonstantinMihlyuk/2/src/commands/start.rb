require_relative "../commands/command.rb"
require_relative "../constants/answer.rb"

class Start < Command
  #Class for start command
  def say(message)
    @dialog_step = 0

    Answer::START_COMMANDS
  end

end