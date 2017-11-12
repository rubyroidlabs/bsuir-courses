require 'telegram/bot'
require_relative 'parser.rb'
require_relative 'responser.rb'

TOKEN = '451166419:AAGjKqMZQti0T_o9S8tjY8GluJ_KmLYuKos'.freeze

list_of_names = Parser.new.list_of_names

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Привет, #{message.from.first_name}.\n
        Я расскажу тебе об известных мне каминг-аутах."
      )
    else
      text = if Responser.new(message.text, list_of_names).response
               'Да'
             else
               'Не найдено данных'
             end
      bot.api.send_message(
        chat_id: message.chat.id,
        text: text
      )
    end
  end
end
