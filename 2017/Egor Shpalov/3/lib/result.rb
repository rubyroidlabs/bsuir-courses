class Result
  def initialize(bot, message)
    @bot = bot
    @message = message
  end

  def check(text, list)
    bot_text = list.assoc(text.strip)
    bot_text = if bot_text.nil?
                 'No information...'
               else
                 bot_text.last
               end
    @bot.api.send_message(chat_id: @message.from.id, text: bot_text)
  end
end
