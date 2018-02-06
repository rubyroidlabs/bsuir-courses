require_relative 'database'
require 'telegram/bot'
require './lib/message_responder'
require 'pry'

token = '469500161:AAHlrBWxeBV4KTalDc-fm_4YXwTaDf_vlLw'

database = Database.new
database.load_from_file('database.txt')

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    options = { bot: bot, message: message }

    MessageResponder.new(options, database.info).respond
  end
end
