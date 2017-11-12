require_relative 'message_sender'
class MessageResponder
  attr_reader :message
  attr_reader :bot

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
  end

  def answer_with_greeting_message
    answer_with_message 'Привет братюня'
  end

  def question
    answer_with_message 'Введи известного человека'
  end

  def start
    answer_with_greeting_message
    question
  end

  def stop
    answer_with_message 'Пока мой герой'
  end

  def answer_with_message(text)
    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end
end
