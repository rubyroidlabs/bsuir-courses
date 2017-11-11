require 'telegram/bot'
require './lib/message_responder'
require 'pry'

token = ENV['TELEGRAM_TOKEN']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    options = {bot: bot, message: message}

    MessageResponder.new(options).respond
  end
end
