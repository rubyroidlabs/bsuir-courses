# class for send messages to telegram bot
class MessageSender
  attr_reader :bot
  attr_reader :text
  attr_reader :chat
  attr_reader :answers

  def initialize(options)
    @bot = options[:bot]
    @text = options[:text]
    @chat = options[:chat]
    @answers = options[:answers]
  end

  def send
    bot.api.send_message(chat_id: chat.id, text: text)
  end
end
