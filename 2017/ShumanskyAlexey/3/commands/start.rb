class Start
  def initialize(bot, message)
    @bot = bot
    @message = message
  end

  def send_mess
    @bot.api.send_message(
      chat_id: @message.chat.id,
      text: "Привет, #{@message.from.first_name}.  Я расскажу тебе какие актеры
и при каких обстоятельствах совершили каминг-аут.
\nСписок актеров, которых я вычислил, можно посмотреть нажав  /status"
    )
  end
end
