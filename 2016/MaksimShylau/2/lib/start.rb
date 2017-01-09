# It can send messages
class Start < Command
  def initialize(bot, message, hello)
    super(bot, message)
    send_message(hello)
  end
end
