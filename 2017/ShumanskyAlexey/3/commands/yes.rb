class Yes
  def initialize(bot, message, data, result)
    @bot = bot
    @message = message
    @data = data
    @result = result
  end

  def send_mess
    if @result.last.class == Hash
      @bot.api.send_message(
        chat_id: @message.chat.id,
        text: @result.last['info']
      )
      @result = []
    else
      @bot.api.send_message(
        chat_id: @message.chat.id,
        text: 'Не найдено данных, повторите ввод'
      )
    end
  end
end
