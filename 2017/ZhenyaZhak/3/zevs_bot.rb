require 'telegram/bot'
require 'json'
require_relative 'work_with_message'

token = '482252225:AAHHu2cYBJQHuWfyoRj2zfSE9lVGvzKpqGU'

Telegram::Bot::Client.run(token) do |bot|
  NAME = 0
  STATUS = 1
  INFO = 2
  str = File.read('coming-out.json')
  str = JSON.parse(str)
  flag = 0
  status = 0
  bot.listen do |message|
    if flag == 1 && message.text == 'да'
      bot.api.send_message(chat_id: message.chat.id, text: "#{str[status][STATUS]}")
      bot.api.send_message(chat_id: message.chat.id, text: "#{str[status][INFO]}")
      flag = 0
      next
    end
    if message.text == 'нет'
      bot.api.send_message(chat_id: message.chat.id, text: "Значит, это нормальный человек.")
      next
    end
    status = WorkWithMessage.find_by_name(message.text, str)
    if status >= 0 && status < str.size
      bot.api.send_message(chat_id: message.chat.id, text: "#{str[status][STATUS]}")
      bot.api.send_message(chat_id: message.chat.id, text: "#{str[status][INFO]}")
    else
      bot.api.send_message(chat_id: message.chat.id, text: "Возможно
 вы имели в виду #{str[status - str.size][NAME]}?(да/нет)")
      status -= str.size
      flag = 1
    end
  end
end
