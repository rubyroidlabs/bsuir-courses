require 'telegram/bot'
require 'mechanize'
require_relative 'message_responder.rb'
token = '466601948:AAHaRPXl2i_AweSfy-Qtxj6j3Xn8_EOv3-w'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    options = { bot: bot, message: message }

    MessageResponder.new(options).respond
  end
end
