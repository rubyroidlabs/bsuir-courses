require 'telegram/bot'
require 'redis'

# The general class to send messages
class BotMain
  attr_reader :bot, :user_id

  def initialize(bot, message_chat_id)
    @bot = bot
    @user_id = message_chat_id

    @redis = Redis.new
  end

  def telegram_send_message(text)
    @bot.api.send_message(chat_id: @user_id, text: text)
  end

  def telegram_send_keybord(text, marker, subjects_numlabs = nil)
    case marker
    when 'reset'
      kb = [
        Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Удаляем', callback_data: 'delete'),
        Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Отмена', callback_data: 'cancel')
      ]
    when 'submit_list'
      kb = []
      subjects_hash = @redis.hgetall("#{@user_id}-subject")
      subjects_hash.each do |key, value|
        kb.push(Telegram::Bot::Types::InlineKeyboardButton.new(text: key, callback_data: key))
      end
    when 'submit_numlabs'
      array_numlabs = @redis.hget("#{@user_id}-subject-numlab", subjects_numlabs).delete('[,]').split
      kb = []
      array_numlabs.each do |count|
        kb.push(Telegram::Bot::Types::InlineKeyboardButton.new(text: count, callback_data: count))
      end
    end
    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
    @bot.api.send_message(chat_id: @user_id, text: text, reply_markup: markup)
  end
end

# Class command '/start'
class StartMessage < BotMain
  def start_command
    telegram_send_message("Привет.\n#{Command_list}")
  end
end

# Class command '/semester'
class BotSemester < BotMain
  def semester_message
    telegram_send_message('Когда начинаем учиться (ДД-ММ-ГГГГ) ?')
    bot.listen do |answer|
      if check_date(answer.text).nil?
        telegram_send_message("'#{answer.text}' - некорректная дата. Соберись и введи дату как положено.")
      else
        @semestr_begin = Date.parse(answer.text)
        telegram_send_message("ОК.\nКогда надо сдать все лабы? (ДД-ММ-ГГГГ) ?")
        break
      end
    end

    bot.listen do |answer|
      if check_date(answer.text).nil?
        telegram_send_message("'#{answer.text}' - некорректная дата. Соберись и введи дату как положено.")
      else
        @semestr_end = Date.parse(answer.text)
        break
      end
    end

    if timing(@semestr_begin, @semestr_end) == true
      @redis.hmset("#{@user_id}-semestr", 'days_remain', @days_remain, 'days_semestr', @days_semestr, 'days_passed', @days_passed)
      telegram_send_message("Продолжительность семестра с #{@semestr_begin.strftime('%d-%m-%Y')} по #{@semestr_end.strftime('%d-%m-%Y')} составляет #{@days_semestr} дней.\nПо состоянию на сегодня, осталось #{@days_remain} дней.")
    else telegram_send_message("Смотри, какая штука...\nЛибо ты ошибся при вводе конца семестра, либо время сдачи уже прошло.\nКонец семестра: #{@semestr_end.strftime('%d-%m-%Y')}, а сегодня уже #{@today.strftime('%d-%m-%Y')}.")
    end
  end

  def check_date(date_string)
    if date_string.scan(/\d/).size.between?(7, 8)
      date_hash = Date._parse(date_string)
      if Date.valid_date?(date_hash[:year].to_i, date_hash[:mon].to_i, date_hash[:mday].to_i) && date_hash[:year].to_i.between?(Date.today.year, Date.today.year + 7)
        true
      end
    end
  end

  def timing(begin_date, last_date)
    @today = Date.today
    if last_date > @today
      @days_remain = (last_date - @today).to_i
      @days_semestr = (last_date - begin_date).to_i
      @days_passed = (@today - begin_date).to_i
      true
    end
  end
end

# Class command '/subject'
class BotSubject < BotMain
  def subject_message
    telegram_send_message('Какой предмет учим?')
    bot.listen do |answer|
      if /^[a-zA-Z]+$|^[а-яА-Я]+$/ =~ answer.text
        @lesson = answer.text
        break
      else telegram_send_message('Подход, конечно оригинальный,только название нужно вводить буквами.')
      end
    end

    telegram_send_message('Сколько лабораторных работ по нему нужно сдать?')
    bot.listen do |answer|
      if /^\d(\d)*?$/ =~ answer.text && answer.text.to_i <= 28
        @lesson_numlab = answer.text
        telegram_send_message('Ок, записал.')
        @redis.hset("#{@user_id}-subject", @lesson, @lesson_numlab)
        break
      elsif /^\d(\d)*?$/ =~ answer.text && answer.text.to_i > 28
        telegram_send_message('Ух ты, а в универе знают об этом?.')
      else
        telegram_send_message('Подход, конечно оригинальный,только количество нужно вводить цифрами.')
      end
    end
  end
end

# Class command '/status'
class BotStatus < BotMain
  def status_message
    @days_remain = @redis.hget("#{@user_id}-semestr", 'days_remain')
    @days_passed = @redis.hget("#{@user_id}-semestr", 'days_passed')
    @days_semestr = @redis.hget("#{@user_id}-semestr", 'days_semestr').to_i

    if @redis.hgetall("#{@user_id}-subject") == {}
      telegram_send_message("Определи задачу.\nДобавить предмет и количество лабораторных работ по нему можно с помощью '/subject'")
    elsif @days_remain.nil?
      telegram_send_message("Давай обозначим сроки.\nУстановить начало и конец семестра можно с помощью команды '/semester'")
    else
      telegram_send_message("Сегодня #{Date.today.strftime('%d-%m-%Y')}. Прошло #{@days_passed}, осталось #{@days_remain} дней.\n\nК этому времени у тебя должны быть сдано:")
      @redis.hgetall("#{@user_id}-subject").each do |key, value|
        lesson_complete(value.to_i)
        telegram_send_message("#{key} - #{@accomplished} из #{value} работ")
      end
      telegram_send_message('Так держать!')
    end
  end

  def lesson_complete(workshops)
    days_per_workshop = @days_semestr / workshops
    days_gone = @days_semestr - @days_remain.to_i
    @accomplished = if days_per_workshop.positive?
                      days_gone / days_per_workshop
                    else 0
                    end
  end
end

# Class command '/submit'
class BotSubmit < BotMain
  def submit_message
    if @redis.hgetall("#{@user_id}-subject") == {}
      telegram_send_message("Список пуст.\nДобавить предмет и количество лабораторных работ по нему можно с помощью '/subject'")
    else
      telegram_send_keybord('Молодец! Какой предмет сдал(а)?', 'submit_list')
    end
  end

  def submit_hundler(input)
    input_submit = input
    if /^[a-zA-Z]+$|^[а-яА-ЯЁё]+$/ =~ input_submit
      @subject_name = input
      if @redis.hget("#{@user_id}-subject-numlab", input).nil?
        num_lab(input_submit)
      elsif @redis.hget("#{@user_id}-subject-numlab", input) == '[]'
        telegram_send_message('Ты уже рассчитался по этому предмету!')
      else
        telegram_send_keybord('Какая лаба?', 'submit_numlabs', input)
      end
    elsif /^\d(\d)*?$/ =~ input_submit
      lab_remove(@subject_name, input)
      telegram_send_message('Красавчег!')
    end
  end

  def num_lab(name)
    num = @redis.hget("#{@user_id}-subject", name).to_i
    numlabs = (1..num).to_a
    @redis.hset("#{@user_id}-subject-numlab", name, numlabs.to_s)
    telegram_send_keybord('Какая лаба?', 'submit_numlabs', name)
  end

  def lab_remove(name, num_labs)
    array_numlabs = @redis.hget("#{@user_id}-subject-numlab", name).delete('[,]').split
    array_numlabs.delete(num_labs)
    array_numlabs_numbers = []
    array_numlabs.each { |unit| array_numlabs_numbers.push(unit.to_i) }
    @redis.hset("#{@user_id}-subject-numlab", name, array_numlabs_numbers.to_s)
  end
end

# Class command '/reset'
class BotReset < BotMain
  def reset_message
    if @redis.hgetall("#{@user_id}-semestr") == {} && @redis.hgetall("#{@user_id}-subject") == {}
      telegram_send_message("Что бы что-то удалить, сначала надо что-то добавить...\nПодробнее смотри '/start'")
    else
      telegram_send_keybord('Твои данные будут удалены безвозвратно. Продолжить?', 'reset')
    end
  end

  def reset_command
    @redis.del("#{@user_id}-subject", "#{@user_id}-semestr", "#{@user_id}-subject-numlab")
    telegram_send_message('Готово. Все успешно очищено.')
  end
end

token = '241685650:AAGzEF3j8-Eck5N-itfwm4W65JIOtosk-5g'

Command_list = "Я могу тебе помочь сдать вовремя все лабы.
Вот список того, что я умею:\n
/start - Приветствие и отображение всех доступных команд
/semester - Ввод даты начала и конца семестра
/subject - Добавляет предмет и количество лабораторных работ по нему
/status - Отображает список лабораторных работ, которые нужно сдать
/submit - Учитывает сдачу лабораторной работы ( Я сдал(а) )
/reset - Сбрасывает и удаляет все пользовательские данные".freeze

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message
    when Telegram::Bot::Types::Message
      case message.text
      when '/start'
        StartMessage.new(bot, message.chat.id).start_command
      when '/semester'
        BotSemester.new(bot, message.chat.id).semester_message
      when '/subject'
        BotSubject.new(bot, message.chat.id).subject_message
      when '/status'
        BotStatus.new(bot, message.chat.id).status_message
      when '/submit', 'я сдал', 'я сдала', 'Я сдал', 'Я сдала'
        @submit_class = BotSubmit.new(bot, message.chat.id)
        @submit_class.submit_message
      when '/reset'
        @reset_class = BotReset.new(bot, message.chat.id)
        @reset_class.reset_message
      else
        bot.api.send_message(chat_id: message.chat.id, text: "И что бы это значило..? Я тебя не понимаю =(\nСпиок известных мне комманд можно посмотреть с помощью '/start'.")
      end
    when Telegram::Bot::Types::CallbackQuery
      case message.data
      when 'delete'
        @reset_class.reset_command
      when 'cancel'
        bot.api.send_message(chat_id: message.from.id, text: 'Фууух, еле успел... Сброс отменен.')
      else
        @submit_class.submit_hundler(message.data)
      end
    end
  end
end
