require 'rubygems'
require 'telegram/bot'
require_relative './lib/calendar.rb'

class Base
  token = '273396926:AAEP9YaekvsgpG0gcMSmKMOWMXZWrrfZHLs'
  Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
      case message.text
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Здраствуй, #{message.from.first_name}!")
          bot.api.send_message(chat_id: message.chat.id, text: "Пару вещей, которые ты должен знать: \n
            /start - ты его видишь \n
            /semestr - напоминание, чтобы не приуныть перед сессией (Даты вводить в стиле год-месяц-день или наоборот)\n
            /subject - выплесни свой страх сюда, и кол-во страха тоже с: \n
            /status - познай страх, чтобы не приуныть \n
            /reset - rm -rf /dev/null \n
            Развлекайся ;3")
        when '/semestr'
          bot.api.send_message(chat_id: message.chat.id, text: "Напомни дату, когда ТЗ было оформлено: ")
          bot.listen do |anwser|
            if valid?(anwser.text) == false
              bot.api.send_message(chat_id: message.chat.id, text: "Так и приуныть можно, введи дату правильно")
            else 
              @begin = Date.parse(anwser.text)
              break
            end
          end

          bot.api.send_message(chat_id: message.chat.id, text: "Когда дедлайн?")
          bot.listen do |anwser|
            if valid?(anwser.text) == false
              bot.api.send_message(chat_id: message.chat.id, text: "Стебешься? Введи дату правильно")
            else 
              @end = Date.parse(anwser.text)
              break
            end
          end

          if sem_date(@date1, @date2) == true					
            bot.api.send_message(chat_id: message.chat.id, text: "У тя #{@today} дней до дедлайна")
          end
      end
    end
  end
end	