require_relative 'message_sender'

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
      gay_or_not(@message.text)
    end
  end

  def answer_with_greeting_message
    answer_with_message "Добро пожаловать, #{message.from.first_name}"
  end

  def answer_with_farewell_message
    answer_with_message "До свидания, #{message.from.first_name}"
  end

  def gay_or_not
    if @data.include?(@message.text)
      bot.api.sendMessage(chat_id: message.chat.id, text: "Каминг-аут совершен")
    else
      bot.api.sendMessage(chat_id: message.chat.id, text: "Нет данных")
    end
  end

  def answer_with_message(text)
    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end
end
