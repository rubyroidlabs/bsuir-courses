require 'telegram/bot'
require_relative 'answer'
require_relative 'parser'

token = '475042061:AAFy8hx4NuAoqeMjf8vHH8FPxQoJsuJq2ys'
data = Parser.new.receive_data

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    Answer.new(message, bot, data).reply
  end
end
