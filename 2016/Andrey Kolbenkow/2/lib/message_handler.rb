require_relative 'user.rb'
require_relative 'commands/command_processor.rb'

class MessageHandler
  def initialize
    @command_processor = CommandProcessor.new
  end

  def decide_what_to_do_with_this_shit(message, user)
    user.parse message
    user.create if user.not_exist?
    @command_processor.start(message, user)
  end
end
