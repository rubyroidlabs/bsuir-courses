class Result
  def initialize(bot, message)
    @bot = bot
    @message = message
  end

  def check(text, list)
    bot_text = list.assoc(text.strip)
    bot_text = if bot_text.nil?
                 levenstein_search(text, list)
               else
                 bot_text.last
               end
    @bot.api.send_message(chat_id: @message.from.id, text: bot_text)
  end

  def levenstein_search(text, list)
    list.each do |person|
      search_person = Search.new
      search_person.str_data = person.first
      search_person.str_user = text.strip
      if search_person.distance <= LEVENSTEIN_SEARCH_DISTANCE
        return "Maybe you mean #{search_person.variant}?"
      end
    end
    'No information...'
  end
end
