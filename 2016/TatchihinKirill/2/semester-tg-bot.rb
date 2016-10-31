
require 'telegram/bot'
require 'date'
#require_relative
require 'redis'
require './lib/User.rb'
require_relative './lib/Semester.rb'
require_relative './lib/Start.rb'
require_relative './lib/Status.rb'
require_relative './lib/MainCommand.rb'
require_relative './lib/Subjects.rb'
require_relative './lib/Reset.rb'
require_relative './lib/calculations.rb'
TOKEN = '298272856:AAEMgCksHqhx__47RvnrgWkk7dq0Ycjt-Sw'
$new_client = false
temp = []
def intro(user_name)
  return "Привет, #{user_name}. Тут такое дело: в универе надо сдавать лабы. Но не волнуйся, я тебе помогу. Вот, что я умею \n/semester - запоминаю даты начала и конца семестра \n /status - напоминаю тебе, какие лабы осталось сдать \n /subject - добавляем новый предмет, по которому надо было бы сдать лабы \n /reset - забываем даты семестра и лабы"
end
$redis = Redis.new
temp = ''
command = MainCommand.new
Telegram::Bot::Client.run(TOKEN) do |bot|
  user = User.new
  user.subjects = {}
  bot.listen do |message|
    command.name_of_the_command = message.text
    case command.name_of_the_command
    when '/start'
      MainCommand.open_and_check(message.from.id)
      user.name = message.from.first_name
      MainCommand.command(message, bot, intro(user.name))
    when '/semester'
    	user.action = 'semester'
    	SemesterCommand.command(message, bot, "Так-с, что это тут у нас? Новый семестр? Давай обозначим дедлайн. Для этого скажи мне, с какого ты курса:", user.action)
    when '/subject'
      user.action = 'subject'
      SubjectsCommand.command(message, bot, "Что сдаём?", user.action)
    when '/status'
      user.subjects = {}
      user.load_object(message.from.id)
      StatusCommand.command(message, bot,"Так-с, что тебе надо сдать...Ах, да, вот что:", user, user.end_semester, user.subjects, message.from.id)
    when '/reset'
      ResetCommand.command(user.subjects, user.start_semester, user.end_semester, message.from.id)
      bot.api.send_message(chat_id: message.chat.id, text: "Только тссссс. Не надо всем говорить, что сдал лабы, а на самом деле просто отменил их в своём боте")
    when '/submit', /я сдал/
      MainCommand.command(message, bot, 'красава')
    when ""
      MainCommand.command(message, bot, intro(user.name))
    else
    	case user.action
    	when 'semester'
        SemesterCommand.semester(message, bot, user, message.from.id, user.action)
      #  user.write_semester_to_file(message.from.id, user.start_semester, user.end_semester)
      when 'subject'
        bot.api.send_message(chat_id: message.chat.id, text: "Сколько лаб по предмету?")
        temp = message.text
        user.action = 'count_of_labs'
      when 'count_of_labs'
        SubjectsCommand.end_command(bot, message, message.from.id, temp, message.text, user.subjects, user.action)

      end
    end
  end
end
