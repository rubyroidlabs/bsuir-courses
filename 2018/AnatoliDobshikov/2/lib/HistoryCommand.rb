# query history
require 'pg'
require 'active_record'
require 'telegram/bot'
require_relative 'TeleBotCommand'
require_relative 'model/Request'

class HistoryCommand < TeleBotCommand
  def reply
    # load all requests for current user
    requests = Request.where(user_id: @message.from.id)
    # if user haven't got queries YET
    if requests.length == 0
      return "You haven't got any queries. \nType /help to see the commands list."
    end
    # form history
    history = "History of #{@message.from.first_name} #{@message.from.last_name}.\n"
    requests.length.times do |index|
      history += "#{requests[index].updated_at}: searching for #{requests[index].query} in #{requests[index].repository} repository.\n"
    end
    # cut VERY long history
    if history.length > 4090
      history = "..." + history.slice((history.length - 4090)..(history.length - 1))
    end
    history
  end
end
