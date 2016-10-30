require 'rubygems'
require 'telegram/bot'
require 'redis'
require 'json'
require_relative 'db'
require_relative 'command'
require_relative 'user'
require_relative 'start'
require_relative 'data'
require_relative 'parse_date'
require_relative 'semester'
require_relative 'subject'
require_relative 'status'
require_relative 'reset'

HELLO = "*Привет*. Я тебе смогу помочь сдать все лабы, чтобы мамка не ругалась. Смотри список что я умею:
/start - выводит приветствие и описание всех доступных команд
/semester - запоминает даты начала и конца семестра
/subject - добавляет предмет и количество лабораторных работ по нему
/status - выводит твой список лаб, которые тебе предстоит сдать
/reset - сбрасывает для пользователя все данные."
SEM_START = "Введи дату начала семестра. \nНапример, *01.09.2016*"
WHAT_SUBJECT = "Какой предмет учим?"
HOW_MANY_LABS = "Сколько лаб надо сдать?"
DO_IT = "Давай поднажмём! :)"
DELETED = "Все данные удалены"
class TelegramBot
  def initialize
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.listen do |message|
        user = User.new(message.chat.id) 
        db = Database.new(user.id)
        command = Command.new(bot, message)
        hash = db.get_hash(user.id)
        user.status = hash["user_status"]
        subject_count = hash["subject_count"]
        if user.check_status(user.status, user.id, hash, db.redis, command, message, subject_count) then next end
        db.set_hash(hash, user.id)
        case message.text
        when '/start' # годнота
          start = Start.new(bot, message, HELLO)
        when '/semester' # годнота
          hash = db.get_hash(user.id)
          sem = Semester.new(bot, message)
          sem.sem_start = hash["sem_start"]
          if sem.sem_start.nil?
            sem.send_message(SEM_START)
            user.status = "wanna_sem_start"
            hash["user_status"] = user.status
            db.set_hash(hash, user.id)
            next
          end
          start_parse = DateParser.new(hash["sem_start"])
          end_parse = DateParser.new(hash["sem_end"])
          command.send_message(DateParser.difference(end_parse, start_parse))
        when '/subject' # годнота
          hash = db.get_hash(user.id)
          command.send_message(WHAT_SUBJECT)
          hash["user_status"] = "wanna_subject"
          db.set_hash(hash, user.id)
          next
        when '/status' # годнота
          hash = db.get_hash(user.id)
          status = Status.new(bot, message)
          if hash["sem_start"].nil?
            status.send_message("Сначала укажи границы семестра (/semester)")
            next
          end
          if hash["subject_count"] == 0
            status.send_message("Сначала укажи предметы (/subject)")
            next
          end
          sem_start = DateParser.new(hash["sem_start"])
          sem_end = DateParser.new(hash["sem_end"])
          status.send_message("К этому времени у тебя должно быть сдано:")
          1.upto(hash["subject_count"]) do |i|
            hash["subject"][i-1]["to_do"] = status.must_be_done(hash["subject"][i-1]["labs_count"], sem_start, sem_end)
            status.send_message("*" + hash["subject"][i-1]["subject_name"].to_s + "* - *" + hash["subject"][i-1]["to_do"].to_s + "* из *" + hash["subject"][i-1]["labs_count"].to_s + "*")
          end
          p hash 
          status.send_message(DO_IT)
          db.set_hash(hash, user.id)
        when '/reset'
          Reset.new(bot, message, db.redis, user.id)
        else
          command.send_message("Моя твоя не понимать")
        end
      end
    end
  end
end
