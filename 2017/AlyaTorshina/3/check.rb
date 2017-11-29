require_relative 'data_parser.rb'

class Check
  def initialize(message, data, bot)
    @message = message
    @data = data
    @bot = bot
  end

  def include?
    @data.include?(@message.text) ? answer(true) : answer(false)
  end

  def answer(report)
    if report
      @bot.api.send_message(chat_id: @message.chat.id, text: 'Yes')
    else
      @bot.api.send_message(chat_id: @message.chat.id, text: 'No data found')
    end
  end
end
