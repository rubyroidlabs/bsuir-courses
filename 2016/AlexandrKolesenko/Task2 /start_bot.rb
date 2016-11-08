
require_relative "logic.rb"
require "telegram/bot"
token = "YOUR_TELEGRAM_TOKEN"

@stack = {}

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when "/start"
      bot.api.sendMessage(chat_id: message.chat.id, text: "Привет, #{message.from.first_name}")
      bot.api.sendMessage(chat_id: message.chat.id, text: "/start - выводит приветствие и описание всех доступных команд
        /semester - запоминает даты начала и конца семестра
		/subject - добавляет предмет и количество лабораторных работ по нему
        /status - выводит твой список лаб, которые тебе предстоит сдать
        /reset - сбрасывает для пользователя все данные.")
    when "/semester"
      bot.api.sendMessage(chat_id: message.chat.id, text: "Когда начинаем учиться?(ГГГГ-ММ-ДД или ДД-ММ-ГГГГ)")
      bot.listen do |answer|
        if v_date?(answer.text) == false
          bot.api.sendMessage(chat_id: message.chat.id, text: "#{answer.from.first_name}, ты пишешь шляпу. Нормально введи дату!")
        else
          @date1 = Date.parse(answer.text)
          bot.api.sendMessage(chat_id: message.chat.id, text: "Когда заканчиваем учиться?(ГГГГ-ММ-ДД или ДД-ММ-ГГГГ)")
          break
        end
      end
      bot.listen do |answer|
        if v_date?(answer.text) == false
          bot.api.sendMessage(chat_id: message.chat.id, text: "#{answer.from.first_name}, ты пишешь шляпу. Нормально введи дату!")
        else
          @date2 = Date.parse(answer.text)
          break
        end
      end
      if countdown(@date1, @date2) == true
        bot.api.sendMessage(chat_id: message.chat.id, text: "В запасе дней:#{@eta}")
      else
        bot.api.sendMessage(chat_id: message.chat.id, text: "Время вышло")
      end

    when "/subject"
      bot.api.sendMessage(chat_id: message.chat.id, text: "Как называется предмет?")
      bot.listen do |answer|
        @task = answer.text
        break
      end

      bot.api.sendMessage(chat_id: message.chat.id, text: "Сколько лаб нужно сдать?")
      bot.listen do |answer|
        if !/\d+/.match(answer.text) == true
          bot.api.sendMessage(chat_id: message.chat.id, text: "#{answer.from.first_name}, будь человеком введи число!")
        else
          @task_num = answer.text
          bot.api.sendMessage(chat_id: message.chat.id, text: "Принял.")
          break
        end
      end
      @abgx = Hash[@task, @task_num]
      @stack = @stack.merge(@abgx)

    when "/status"
      if @eta.nil?
        bot.api.sendMessage(chat_id: message.chat.id, text: "Введи начало и конец семестров")
      else
        bot.api.sendMessage(chat_id: message.chat.id, text: "Осталось времени #{@eta} дней")
        @stack.each do |key, value|
          taskcalc(value.to_i)
          bot.api.sendMessage(chat_id: message.chat.id, text: "#{key} - #{@accomplished} из #{value} предметов должны быть уже сданы")
        end
      end
    when "/reset"
      @stack = {}
      @eta = nil
      @sum_of_days = nil
    end
  end
end
