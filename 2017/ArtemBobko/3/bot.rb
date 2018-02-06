require 'telegram/bot'
require './lib/bot/message_responder'
require './lib/parser/parser'
require 'pry'

Parser.clear_database
Parser.get_celebrities_to_file

token = '314934922:AAHXOb8EjuDDuu-Xr8ijDoEaC9q7mwZPoC0'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    options = { bot: bot, message: message }

    MessageResponder.new(options).respond
  end
end
