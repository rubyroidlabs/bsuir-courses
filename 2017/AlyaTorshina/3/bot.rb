require 'telegram/bot'
require_relative 'data_parser.rb'
require_relative 'check.rb'

token = ENV['TELEGRAM_TOKEN']

data_parser = DataParser.new
data_parser.record
data = data_parser.read

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    Check.new(message, data, bot).include?
  end
end
