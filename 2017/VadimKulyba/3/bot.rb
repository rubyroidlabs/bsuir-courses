require 'telegram/bot'
require_relative 'lib/message_answer'

TOKEN = ENV['TELEGRAM_TOKEN']

Telegram::Bot::Client.run(TOKEN) do |bot|
  answer = MessageAnswer.new
  bot.listen do |message|
    options = { bot: bot, message: message }
    answer.init_message(options)
    answer.respond
  end
end
