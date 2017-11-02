class Result
  def initialize(bot, message)
    @bot = bot
    @message = message
  end
  
  def check(text, list)
    bot_text = if list.flatten.include?(text.strip)
                 i = list.flatten.index(text)
                 "Yes, #{list.flatten[i + 1].scan(/\w+/).join('')}"
               else
                 'No information.'
               end
    @bot.api.send_message(chat_id: @message.from.id, text: bot_text)
  end
end
