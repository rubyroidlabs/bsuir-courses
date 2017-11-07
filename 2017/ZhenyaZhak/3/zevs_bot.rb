require 'telegram/bot'
require 'json'
require_relative 'work_with_message'

token = '482252225:AAHHu2cYBJQHuWfyoRj2zfSE9lVGvzKpqGU'
NA = 0
ST = 1
IN = 2
str = File.read('coming-out.json')
str = JSON.parse(str)

Telegram::Bot::Client.run(token) do |bot|
  flag = 0
  st = 0
  bot.listen do |message|
    if flag == 1 && message.text == 'да'
      bot.api.send_message(chat_id: message.chat.id, text: "#{str[st][ST]}
#{str[st][IN]}")
      flag = 0
      next
    end
    if message.text == 'нет'
      bot.api.send_message(chat_id: message.chat.id, text: 'Увы(')
      next
    end
    st = WorkWithMessage.find_by_name(message.text, str)
    if st >= 0 && st < str.size
      bot.api.send_message(chat_id: message.chat.id, text: "#{str[st][ST]}
#{str[st][IN]}")
    else
      bot.api.send_message(chat_id: message.chat.id, text: "Возможно
 вы имели в виду #{str[st - str.size][NA]}?(да/нет)")
      st -= str.size
      flag = 1
    end
  end
end
