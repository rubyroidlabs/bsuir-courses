require './lib/bot/reply_markup_formatter'

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
    if reply
      bot.api.send_message(chat_id: chat.id, text: text, reply_markup: reply)
    else
      bot.api.send_message(chat_id: chat.id, text: text)
    end
  end

  private

  def reply
    if answers
      ReplyMarkupFormatter.new(answers).get_markup
    end
  end
end
