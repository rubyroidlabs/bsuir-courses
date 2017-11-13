require './lib/message_sender'
# class for resppond telegram bot
class MessageResponder
  attr_reader :message
  attr_reader :bot

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @reader = options[:reader]
  end

  def respond
    if @reader.comes_out?(@message.text)
      answer_with_message('Да')
    else
      answer_with_message('Нет')
    end
  end

  private

  def answer_with_message(text)
    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end
end
