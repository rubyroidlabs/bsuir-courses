require 'telegram/bot'
require_relative 'lib/message_handler'

data = JSON.parse(File.read('resource/data.json'))
message_handler = MessageHandler.new
TOKEN = ENV['TELEGRAM_TOKEN']

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      message_handler.call_answer_start(bot, message)
    when '/update'
      message_handler.call_answer_update(bot, message)
    when '/stop'
      message_handler.call_answer_stop(bot, message)
    else
      message_handler.call_answer_name(bot, message, data)
    end
  end
end
