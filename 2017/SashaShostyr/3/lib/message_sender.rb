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
    if markup
      bot.api.send_message(chat_id: chat.id, text: text, reply_markup: markup)
    else
      bot.api.send_message(chat_id: chat.id, text: text, parse_mode: 'HTML')
    end
  end

  private

  def markup
    ReplyMarkupFormatter.new(answers).getmarkup if answers
  end
end
