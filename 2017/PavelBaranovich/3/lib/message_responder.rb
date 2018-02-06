require './lib/message_sender'

class MessageResponder
  attr_reader :message
  attr_reader :bot

  def initialize(options, database)
    @bot = options[:bot]
    @message = options[:message]
    @database = database
  end

  def respond
    answer = if message.text == '/start'
               'Привет, давай выясним, кто совершал каминг-аут, а кто нет!'
             elsif message.text == '/stop'
               'Пока!'
             elsif search_in_database(message.text + "\n")
               'Да'
             else
               'Не найдено данных'
             end

    answer_with_message(answer)
  end

  private

  def search_in_database(text)
    if @database.nil?
      false
    else
      @database.include?(text)
    end
  end

  def answer_with_message(text)
    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end
end
