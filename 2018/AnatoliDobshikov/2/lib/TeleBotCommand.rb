require 'telegram/bot'
require_relative 'model/User.rb'
# super class for all commands
class TeleBotCommand
  # constructor
  def initialize(message = Telegram::Bot::Types::Message.new(), user = User.new)
    @message = message
    @user = user
  end
  # here is the answer to wrong request
  def reply
    "I'm sorry I do not understand you.\nTry to type /help to see what I can understand."
  end
end
