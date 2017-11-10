class Status
  def initialize(bot, message, data)
    @bot = bot
    @message = message
    @data = data
  end

  def send_mess
    actors = ''
    @data.each do |hash|
      actors << hash['actors'] << '  #  '
    end

    @bot.api.send_message(
      chat_id: @message.chat.id,
      text: actors
    )
  end
end
