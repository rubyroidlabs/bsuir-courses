require_relative "logic.rb"
require_relative "commands.rb"
require "redis"
require "telegram/bot"
token = "YOUR_TELEGRAM_TOKEN"

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
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
      Reset.new(bot, message).run
    end
  end
end
