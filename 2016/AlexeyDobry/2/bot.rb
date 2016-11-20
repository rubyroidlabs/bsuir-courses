require "rubygems"
require "telegram/bot"
require_relative "./lib/calendar.rb"
require_relative "./lib/subject.rb"

# я не могу понять, тут коммент просят? Нуок, тип база
class Base
  token = "273396926:AAEP9YaekvsgpG0gcMSmKMOWMXZWrrfZHLs"
  @hash = {}
  Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
      case message.text
        when "/start"
          bot.api.send_message(chat_id: message.chat.id, text: "Здраствуй, #{message.from.first_name}!")
          bot.api.send_message(chat_id: message.chat.id, text: "Пару вещей, которые ты должен знать: \n
            /start - ты его видишь \n
            /semestr - напоминание, чтобы не приуныть перед сессией (Даты вводить в стиле год-месяц-день или наоборот)\n
            /subject - выплесни свой страх сюда, и кол-во страха тоже с: \n
            /status - познай страх, чтобы не приуныть \n
            /reset - rm -rf /dev/null \n
            Развлекайся ;3")
        when "/semestr"
          bot.api.send_message(chat_id: message.chat.id, text: "Напомни дату, когда ТЗ было оформлено: ")
          if @today.nil?
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
            if sem_date(@begin, @end) == true
              bot.api.send_message(chat_id: message.chat.id, text: "У тя #{@today} дней до дедлайна")
            end
          else
            bot.api.send_message(chat_id: message.chat.id, text: "У тя #{@today} дней до дедлайна")
          end
        when "/subject"
          bot.api.send_message(chat_id: message.chat.id, text: "От какого предмета избавляемся?")
          bot.listen do |anwser|
            @sub = anwser.text
            break
          end
          bot.api.send_message(chat_id: message.chat.id, text: "Сколько лаб?")
          bot.listen do |anwser|
            if !/\d+/.match(anwser.text) == true then
              bot.api.send_message(chat_id: message.chat.id, text: "Пффф, я не телепат. Введи число: ")
            else
              @num = anwser.text
              bot.api.send_message(chat_id: message.chat.id, text: "OK")
              break
            end
          end
          @hash = @hash.merge(Hash[@sub, @num])
        when "/status"
          if @today.nil?
            bot.api.send_message(chat_id: message.chat.id, text: ":")
          else
            bot.api.send_message(chat_id: message.chat.id, text: "Sample text статус:")
            @hash.each do |key, value|
              bot.api.send_message(chat_id: message.chat.id, text: "По предмету #{key}:")
              lab_num(value.to_i)
              bot.api.send_message(chat_id: message.chat.id, text: "Ты должен был сдать #{@lab} из #{value} лаб")
            end
          end
        when "/reset"
          @begin = nil
          @end = nil
          @sub = nil
          @num = nil
          @hash = {}
          bot.api.send_message(chat_id: message.chat.id, text: "rm -rf /, gentlemans. Have a nice day! c:")
      end
    end
  end
end
