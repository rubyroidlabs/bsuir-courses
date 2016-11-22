# Base class for initialization
class Base
  attr_accessor :bot

  def initialize(bot, message)
    @redis = Redis.new
    @message = message
    @bot = bot
    @user_id = message.chat.id
    # sm = ->(ms) { bot.api.sendMessage(chat_id: @message.chat.id, text: ms) }
    @name = message.from.first_name
  end

  def sm(text)
    bot.api.sendMessage(chat_id: @message.chat.id, text: text)
  end
end
# Shows all availiable commands
class Start < Base
  def run
    sm("/start - выводит приветствие и описание всех доступных команд
/semester - запоминает даты начала и конца семестра
/subject - добавляет предмет и количество лабораторных работ по нему
/status - выводит твой список лаб, которые тебе предстоит сдать
/reset - сбрасывает для пользователя все данные.")
  end
end
# Input for dates
class Semester < Base
  def first_question
    sm("Когда начинаем учиться?(ГГГГ-ММ-ДД или ДД-ММ-ГГГГ)")
    @bot.listen do |message|
      if v_date?(message.text) == false then sm("#{@name}, ты пишешь шляпу. Нормально введи дату!")
      else
        @date1 = Date.parse(message.text)
        sm("Когда заканчиваем учиться?(ГГГГ-ММ-ДД или ДД-ММ-ГГГГ)")
        break
      end
    end
  end

  def second_question
    @bot.listen do |answer|
      if v_date?(answer.text) == false then sm("#{@name}, ты пишешь шляпу. Нормально введи дату!")
      else
        @date2 = Date.parse(answer.text)
        break
      count_for_sq
    end
  end

  def count_for_sq
    if countdown(@date1, @date2) == true then @redis.hmset("#{@user_id}-date", "begin", @date1, "end", @date2)
      sm("В запасе дней:#{@eta}")
    else
      sm("Время вышло")
    end
  end

  def run
    first_question
    second_question
  end
end
# Input for subject
class Subject < Base
  def first_question
    sm("Как называется предмет?")
    bot.listen do |answer|
      @task = answer.text
      break
    end
  end

  def second_question
    sm("Сколько лаб нужно сдать?")
    bot.listen do |answer|
      if !/\d+/.match(answer.text) == true then sm("#{@name}, будь человеком введи число!")
      else
        sm("Принял.")
        @redis.hmset("#{@user_id}-subj", @task, answer.text)
        break
      end
    end
  end

  def run
    first_question
    second_question
  end
end
# Shows status
class Status < Base
  def subj_status
    stack = @redis.hgetall("#{@user_id}-subj")
    stack.each do |key, value|
      taskcalc(value.to_i)
      sm("#{key} - #{@accomplished} из #{value} предметов должны быть уже сданы")
    end
  end

  def run
    if @redis.hget("#{@user_id}-date", "begin").nil? then sm("Сначала введи начало и конец семестров (/semester)")
    else
      d1 = Date.parse(@redis.hget("#{@user_id}-date", "begin"))
      d2 = Date.parse(@redis.hget("#{@user_id}-date", "end"))
      countdown(d1, d2)
      sm("Осталось времени #{@eta} дней")
      subj_status
    end
  end
end
# Deletes all user data
class Reset < Base
  def run
    @redis.del("#{@user_id}-date", "#{@user_id}-subj")
    sm("Твои данные удалены")
  end
end
