require "rubygems"
require "telegram/bot"
require "redis"
require "json"
require_relative "db"
require_relative "command"
require_relative "user"
require_relative "start"
require_relative "data"
require_relative "parse_date"
require_relative "semester"
require_relative "subject"
require_relative "status"
require_relative "reset"

HELLO = "*Привет*. Я тебе смогу помочь сдать все лабы, чтобы мамка не ругалась. Смотри список что я умею:
/start - выводит приветствие и описание всех доступных команд
/semester - запоминает даты начала и конца семестра
/subject - добавляет предмет и количество лабораторных работ по нему
/status - выводит твой список лаб, которые тебе предстоит сдать
/reset - сбрасывает для пользователя все данные.".freeze
SEM_START = "Введи дату начала семестра. \nНапример, *01.09.2016*".freeze
WHAT_SUBJECT = "Какой предмет учим?".freeze
HOW_MANY_LABS = "Сколько лаб надо сдать?".freeze
DO_IT = "Давай поднажмём! :)".freeze
DELETED = "Все данные удалены".freeze
# Bot logic
class TelegramBot
  def semester_command(db, id, command)
    hash = db.get_hash(id)
    if hash["sem_start"].nil?
      command.send_message(SEM_START)
      hash["user_status"] = "wanna_sem_start"
      db.set_hash(hash, id)
      return
    end
    command.send_message(DateParser.difference(DateParser.new(hash["sem_end"]), DateParser.new(hash["sem_start"])))
  end

  def subject_command(db, id, command)
    hash = db.get_hash(id)
    command.send_message(WHAT_SUBJECT)
    hash["user_status"] = "wanna_subject"
    db.set_hash(hash, id)
  end

  def status_error(db, id, command)
    hash = db.get_hash(id)
    if hash["sem_start"].nil?
      command.send_message("Сначала укажи границы семестра (/semester)")
      return true
    end
    if hash["subject_count"].zero?
      command.send_message("Сначала укажи предметы (/subject)")
      return true
    end
  end

  def hash_to_do(hash, i, sem_start, sem_end, status)
    hash["subject"][i - 1]["to_do"] = status.must_be_done(hash["subject"][i - 1]["labs_count"], sem_start, sem_end)
    hash
  end

  def get_name(hash, i)
    hash["subject"][i - 1]["subject_name"].to_s
    hash
  end

  def get_to_do(hash, i)
    hash["subject"][i - 1]["to_do"].to_s
    hash
  end

  def get_labs_count(hash, i)
    hash["subject"][i - 1]["labs_count"].to_s
  end

  def status_send(hash, i, sem_start, sem_end, status)
    hash = hash_to_do(hash, i, sem_start, sem_end, status)
    status.send_message("*" + get_name(hash, i) + "* - *" + get_to_do(hash, i) + "* из *" + get_labs_count(hash, i) + "*")
  end

  def status_to_do(status, hash, sem_start, sem_end)
    status.send_message("К этому времени у тебя должно быть сдано:")
    1.upto(hash["subject_count"]) do |i|
      status_send(hash, i, sem_start, sem_end, status)
    end
    hash
  end

  def status_command(db, id, bot, message, command)
    return if status_error(db, id, command)
    hash = db.get_hash(id)
    status = Status.new(bot, message)
    sem_start = DateParser.new(hash["sem_start"])
    sem_end = DateParser.new(hash["sem_end"])
    hash = status_to_do(status, hash, sem_start, sem_end)
    status.send_message(DO_IT)
    db.set_hash(hash, id)
  end

  def choose_command(message, db, id, bot, command)
    case message.text
    when "/start" then Start.new(bot, message, HELLO)
    when "/semester" then semester_command(db, id, command)
    when "/subject" then subject_command(db, id, command)
    when "/status" then status_command(db, id, bot, message, command)
    when "/reset" then Reset.new(bot, message, db.redis, id)
    else
      command.send_message("Моя твоя не понимать")
    end
  end

  def init_helper(message, bot)
    user = User.new(message.chat.id)
    db = Database.new(user.id)
    command = Command.new(bot, message)
    hash = db.get_hash(user.id)
    [user, db, command, hash]
  end

  def initialize
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.listen do |message|
        user, db, command, hash = init_helper(message, bot)
        next if user.check_status(user.id, hash, db.redis, command, message)
        choose_command(message, db, user.id, bot, command)
      end
    end
  end
end
