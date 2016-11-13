require 'telegram/bot'

# The general class to send messages
class BotMain
  attr_reader :bot, :user_id

  def initialize(bot, message_chat_id)
    @bot = bot
    @user_id = message_chat_id
  end

  def telegram_send_message(text)
    @bot.api.send_message(chat_id: @user_id, text: text)
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
      telegram_send_message("Продолжительность семестра с #{@semestr_begin.strftime('%d-%m-%Y')} по #{@semestr_end.strftime('%d-%m-%Y')} составляет #{$days_semestr} дней.\nПо состоянию на сегодня, осталось #{$days_remain} дней.")
    else telegram_send_message("Смотри, какая штука...\nЛибо ты ошибся при вводе конца семестра, либо время сдачи уже прошло.\nКонец семестра: #{@semestr_end.strftime('%d-%m-%Y')}, а сегодня уже #{$today.strftime('%d-%m-%Y')}.")
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
    $today = Date.today
    if last_date > $today
      $days_remain = (last_date - $today).to_i
      $days_semestr = (last_date - begin_date).to_i
      $days_passed = ($today - begin_date).to_i
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
        break
      elsif /^\d(\d)*?$/ =~ answer.text && answer.text.to_i > 28
        telegram_send_message('Ух ты, а в универе знают об этом?.')
      else
        telegram_send_message('Подход, конечно оригинальный,только количество нужно вводить цифрами.')
      end
    end

    $content_subject = Hash[@lesson, @lesson_numlab]
    $stack = {} if $stack.nil?
    $stack = $stack.merge($content_subject)
  end
end

# Class command '/status'
class BotStatus < BotMain
  def status_message
    if $stack.nil?
      telegram_send_message("Определи задачу.\nДобавить предмет и количество лабораторных работ по нему можно с помощью '/subject'")
    elsif $days_remain.nil?
      telegram_send_message("Давай обозначим сроки.\nУстановить начало и конец семестра можно с помощью команды '/semester'")
    else
      telegram_send_message("Сегодня #{$today.strftime('%d-%m-%Y')}. Прошло #{$days_passed}, осталось #{$days_remain} дней.\n\nК этому времени у тебя должны быть сдано:")
      $stack.each do |key, value|
        lesson_complete(value.to_i)
        telegram_send_message("#{key} - #{@accomplished} из #{value} работ")
      end
      telegram_send_message('Так держать!')
    end
  end

  def lesson_complete(workshops)
    days_per_workshop = $days_semestr / workshops
    days_gone = $days_semestr - $days_remain
    @accomplished = if days_gone > 0
                      days_gone / days_per_workshop
                    else 0
                    end
  end
end

# Class command '/submit'
class BotSubmit < BotMain
  def submit_message
    telegram_send_message('Молодец! Какой предмет сдал(а)?')
  end
end

# Class command '/reset'
class BotReset < BotMain
  def reset_message
    if ($days_remain.nil? || $days_semestr.nil?) && $stack.nil?
      telegram_send_message("Что бы что-то удалить, сначала надо что-то добавить...\nПодробнее смотри '/start'")
    else
      telegram_send_message('Твои данные будут удалены безвозвратно. Продолжить?')
      $stack = nil
      $days_remain = nil
      $days_semestr = nil
      $content_subject = nil
      telegram_send_message('Готово. Все успешно очищено.')
    end
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
    case message.text
    when '/start'
      StartMessage.new(bot, message.chat.id).start_command
    when '/semester'
      BotSemester.new(bot, message.chat.id).semester_message
    when '/subject'
      BotSubject.new(bot, message.chat.id).subject_message
    when '/status'
      BotStatus.new(bot, message.chat.id).status_message
    when '/submit'
      BotSubmit.new(bot, message.chat.id).submit_message
    when '/reset'
      BotReset.new(bot, message.chat.id).reset_message
    else
      bot.api.send_message(chat_id: message.chat.id, text: "И что бы это значило..? Я тебя не понимаю =(\nСпиок известных мне комманд можно посмотреть с помощью '/start'.")
    end
  end
end
