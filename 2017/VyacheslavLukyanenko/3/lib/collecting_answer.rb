class MakeAnswer
  attr_reader :bot
  attr_reader :chat

  def initialize(options)
    @bot = options[:bot]
    @chat = options[:chat]
  end

  def send(text)
    bot.api.send_message(
      chat_id: chat.id,
      text: text
      )
  end
end
