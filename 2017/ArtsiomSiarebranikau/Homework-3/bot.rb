require 'telegram/bot'
require_relative 'lib/message_responder'
require_relative 'lib/parser'

token = '449365122:AAHClzBrhiHOuySIaz1NB9vsXNgkAhMBkiU'

parser = Parser.new
parser.get_data
data = parser.read_data

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    options = { bot: bot, message: message, data: data }
    MessageResponder.new(options).respond
  end
end
