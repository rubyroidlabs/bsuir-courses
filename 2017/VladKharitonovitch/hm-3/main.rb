require 'telegram/bot'
require_relative 'people.rb'
TOKEN = '495328037:AAFGQUxEEQP3TVbcMh31yjaIP2WEw0-rkX4'.freeze
Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    human = ArrayOfPeople.new(message.text.downcase)
    case message.text
    when '/start', "привет"
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Привет ,#{message.from.last_name}")
    else
      bot.api.send_message(
        chat_id: message.chat.id,
        text: human.pin)
    end
  end
end
