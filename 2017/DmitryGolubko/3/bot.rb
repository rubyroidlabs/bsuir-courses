require 'telegram/bot'
require './lib/message_responder'
require 'pry'
require_relative 'parser'

token = ENV['TELEGRAM_TOKEN']
# token = '495244493:AAFTtKoLyJCbgpORACNhpbY92LqG0FXXslk'

Parser.get_info('http://www.imdb.com/list/ls072706884/')

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    options = { bot: bot, message: message }

    MessageResponder.new(options).respond
  end
end
