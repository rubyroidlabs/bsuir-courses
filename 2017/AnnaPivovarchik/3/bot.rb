require 'telegram/bot'
require './lib/message_responder'
require './lib/parser'
require './lib/status_reader'

token = ENV['TELEGRAM_TOKEN']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    Parser.parse
    options = { bot: bot, message: message, reader: StatusReader.new }

    MessageResponder.new(options).respond
  end
end
