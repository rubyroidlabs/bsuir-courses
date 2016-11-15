
require_relative "logic.rb"
require "telegram/bot"
token = "YOUR_TELEGRAM_TOKEN"

@stack = {}

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
  sm = lambda {|ms| bot.api.sendMessage(chat_id: message.chat.id, text: ms)}
  name = message.from.first_name
    case message.text
    when "/start"
       sm.call("/start - выводит приветствие и описание всех доступных команд
        /semester - запоминает даты начала и конца семестра
		/subject - добавляет предмет и количество лабораторных работ по нему
        /status - выводит твой список лаб, которые тебе предстоит сдать
        /reset - сбрасывает для пользователя все данные.")
    when "/semester"
      sm.call("Когда начинаем учиться?(ГГГГ-ММ-ДД или ДД-ММ-ГГГГ)")
      bot.listen do |message|
        if v_date?(message.text) == false
          sm.call("#{name}, ты пишешь шляпу. Нормально введи дату!")
        else
          @date1 = Date.parse(message.text)
          sm.call("Когда заканчиваем учиться?(ГГГГ-ММ-ДД или ДД-ММ-ГГГГ)")
          break
        end
      end
      bot.listen do |answer|
        if v_date?(answer.text) == false
          sm.call("#{name}, ты пишешь шляпу. Нормально введи дату!")
        else
          @date2 = Date.parse(answer.text)
          break
        end
      end
      if countdown(@date1, @date2) == true
        sm.call("В запасе дней:#{@eta}")
      else
        sm.call("Время вышло")
      end

    when "/subject"
      sm.call("Как называется предмет?")
      bot.listen do |answer|
        @task = answer.text
        break
      end

      sm.call("Сколько лаб нужно сдать?")
        bot.listen do |answer|
          if !/\d+/.match(answer.text) == true
            sm.call("#{name}, будь человеком введи число!")
          else
            @task_num = answer.text
            sm.call("Принял.")
            break
          end
        end
      @abgx = Hash[@task, @task_num]
      @stack = @stack.merge(@abgx)

    when "/status"
      if @eta.nil?
        sm.call("Сначала введи начало и конец семестров (/semester)")
      else
        sm.call("Осталось времени #{@eta} дней")
        @stack.each do |key, value|
          taskcalc(value.to_i)
          sm.call("#{key} - #{@accomplished} из #{value} предметов должны быть уже сданы")
        end
      end
    when "/reset"
      @stack = {}
      @eta = nil
      @sum_of_days = nil
    end
  end
end
