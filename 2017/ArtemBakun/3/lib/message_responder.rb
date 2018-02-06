require './lib/message_sender'

class MessageResponder
  attr_reader :message
  attr_reader :bot

  def initialize(options, data)
    @bot = options[:bot]
    @message = options[:message]
    @data = data
  end

  def respond
    answer = if message.text == '/start'
               'Вас приветствует Coming out bot. Введите имя актёра!'
             elsif message.text == '/stop'
               'Всего хорошего!'
             elsif check(message.text + "\n")
               'Да'
             else
               'Данных не найдено'
             end
    answer_with_message(answer)
  end

  private

  def check(text)
    if @data.nil?
      false
    else @data.include?(text)
    end
  end

  def answer_with_message(text)
    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end
end
