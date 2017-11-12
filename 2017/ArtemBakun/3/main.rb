require_relative 'parser'
require 'pry'
require 'telegram/bot'
require './lib/message_responder'

token = '470573021:AAEcf5xzJFXkDzq49umzKXmKa0FQnlNj7Ag'

data = Parser.new
data.reading_from_file

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    options = { bot: bot, message: message }

    MessageResponder.new(options, data.info).respond
  end
end