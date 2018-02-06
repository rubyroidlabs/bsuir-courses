require './lib/reply_markup_formatter'

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
    if reply_markup
      bot.api.send_message(chat_id: chat.id, text: text,
                           reply_markup: reply_markup)
    else
      bot.api.send_message(chat_id: chat.id, text: text)
    end
  end

  private

  def reply_markup
    if answers
      ReplyMarkupFormatter.new(answers).get_markup
    end
  end
end
