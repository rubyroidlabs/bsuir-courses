class Answer
  def initialize(message, bot, data)
    @message = message
    @bot = bot
    @data = data
  end

  def reply
    case @message.text
    when '/start'
      text = 'Бонжур. Я создан для того, чтобы сказать тебе, является ли ' \
             'какая-либо знаменитость геем, лесбиянкой или бисексуалом. ' \
             'Тебе лишь нужно ввести имя.'
    when '/stop'
      text = 'Орэвуар, мой сладенький'
    else
      result = []
      @data.each { |actor| result << actor if actor.include? @message.text }
      if result.empty?
        text = 'Не найдено данных'
      else
        text = 'Да'
      end
    end
    @bot.api.send_message(chat_id: @message.chat.id, text: text.to_s)
  end
end
