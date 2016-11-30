require "telegram/bot"
require "date"
require "redis"
require "timeout"

require_relative "lib/base"
require_relative "lib/reset"
require_relative "lib/semester"
require_relative "lib/status"
require_relative "lib/subject"
require_relative "lib/submit"

token = "274685898:AAEuPrF8KsgxHyenEt_OGEOO8PGdP2lPTIM"

SKILLS = "Привет. Я тебе смогу помочь сдать все лабы, чтобы мамка не ругалась.
Смотри список что я умею:\n
/start - выводит приветствие и описание всех доступных команд
/semester - запоминает даты начала и конца семестра
/subject - добавляет предмет и количество лабораторных работ по нему
/status - выводит твой список лаб, которые тебе предстоит сдать
/reset - сбрасывает для пользователя все данные.
/submit - запоминаeт сданный предмет".freeze

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when "/start"
      bot.api.sendMessage(chat_id: message.chat.id, text: SKILLS)
    when "/semester"
      semester = Semester.new(bot, message.chat.id)
      semester.send_messages
    when "/subject"
      subject = Subject.new(bot, message.chat.id)
      subject.send_messages
    when "/status"
      status = Status.new(bot, message.chat.id)
      status.send_messages
    when "/reset"
      reset = Reset.new(bot, message.chat.id)
      reset.reset_redis
    when "/submit", /я сдалa?/
      submit = Submit.new(bot, message.chat.id)
      submit.send_messages
    end
  end
end
