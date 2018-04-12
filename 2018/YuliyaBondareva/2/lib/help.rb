require_relative 'base'

class Help < Base
  def send_messages
    telegram_send_message('Hello. See what I\'m doing
      /help
      /set\_repo 
      /show\_repo
      /search 
      /reset')
    end
end
