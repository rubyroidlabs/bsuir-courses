class No
  def initialize(bot, message, result)
    @bot = bot
    @message = message
    @result = result
  end

  def send_mess
    if @result.last.nil?
      @bot.api.send_message(
        chat_id: @message.chat.id,
        text: 'Не найдено данных, повторите ввод'
      )
    else
      @bot.api.send_message(
        chat_id: @message.chat.id,
        text: 'Ну тогда уточните имя актера'
      )
    end
    @result = []
  end
end
