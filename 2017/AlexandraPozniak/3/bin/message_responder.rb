require './bin/message_sender'
require './bin/web_scraper'

class MessageResponder
  attr_reader :message
  attr_reader :bot

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @data = options[:data]
  end

  def respond
    case @message.text
    when '/start'
      answer_with_greeting_message
    when '/stop'
      answer_with_farewell_message
    else
      get_answer
    end
  end

  private

  def on(regex, &block)
    regex =~ message.text

    if $~
      case block.arity
      when 0
        yield
      when 1
        yield $1
      when 2
        yield $1, $2
      end
    end
  end

  def answer_with_greeting_message
    answer_with_message 'Привет!'
  end

  def answer_with_farewell_message
    answer_with_message 'Пока!'
  end

  def answer_with_message(text)
    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end

  def get_answer
    if @data.include?(@message.text)
      bot.api.sendMessage(chat_id: message.chat.id, text: 'Каминг-аут совершен')
    else
      bot.api.sendMessage(chat_id: message.chat.id, text: 'Не найденно данных')
    end
  end
end
