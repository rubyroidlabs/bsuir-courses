require_relative "logic.rb"
require_relative "commands.rb"
require "redis"
require "telegram/bot"
token = "278085899:AAG_kHHWkT5DUiEMg-wCKLAQUvNaKV60bAk"




Telegram::Bot::Client.run(token) do |bot|
  
  bot.listen do |message|
  name = message.from.first_name
    case message.text
    when "/start"
       Start.new(bot, message).run
    when "/semester"
       Semester.new(bot, message).run
    when "/subject"
       Subject.new(bot, message).run
    when "/status"
       Status.new(bot, message).run
    when "/reset"
       Reset.new(bot,message).run
    end
  end
end

