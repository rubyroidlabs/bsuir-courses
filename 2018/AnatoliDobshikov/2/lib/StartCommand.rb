require 'telegram/bot'
require_relative 'TeleBotCommand'
# Cindy introduce itself in this class
class StartCommand < TeleBotCommand
  # introducing and giving the additional information about Cindy
  def reply
    return "Hello, #{@message.from.first_name}.\nMy name is Cindy. I can help you to work with the GitHub.\nYou can type /help to see what I exactly can do."
  end
end
