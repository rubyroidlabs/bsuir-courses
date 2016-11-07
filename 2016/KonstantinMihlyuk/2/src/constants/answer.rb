require 'date'

class Answer

  START_COMMANDS = "/start - Выводит описание всех доступных команд\n/semester - Запоминает даты начала и конца семестра\n/subject - Добавляет предмет и количество лабораторных работ по нему\n/subject_remove - Удаляет предмет\n/status - Выводит твой список лаб, которые тебе предстоит сдать\n/submit - Запоминает какие предметы ты сдал\n/reset - Сбрасывает для пользователя все данные.\n/remind - Самый лучший менеджер напоминалок."
  
  WHEN_BEGIN_TO_LEARN = 'Когда начинаем учиться? (дд-мм-гггг)'
  WHEN_END_TO_LEARN = 'Когда конец занятий? (дд-мм-гггг)'

  FAIL_START_LEARNING_DATE = 'Кажется ты не правильно ввел дату, попробуй ещё раз.'
  FAIL_AVAILABLE_DAYS = 'Мне кажется что ты ввел даты наоборот, я поменяла их местами)'

  WHAT_SUBJECT_TEACH = 'Какой предмет учим?'
  INCORRECT_SUBJECT_NAME = 'Неправильное название предмета'
  HOW_MUCH_LABS_NEED_TAKE = 'Сколько лаб нужно сдать?'

  INCORRECT_LABS_COUNT = 'Мне кажется, ты ввел неправильное колчичество лаб'
  INCORRECT_SUBJECT = 'Я почти уверена, что ты ввел неправильный предмет'
  OK = 'ok'

  NEED_ADD_SUBJECT = 'А давай-ка сначала добавим предметы, нажми /subject'
  DONT_HAVE_LABS = 'Мне кажется такой лабы нет'
  DONT_HAVE_SUBJECTS = 'У тебя пока нет добавленных предметов, жми кнопку /subject'
  DONT_HAVE_SUBJECT = 'Хм, кажется у тебя нет такого предмета.'

  DONT_ENTER_SUBJECTS = 'Жмакни кнопку /subject и задай лабы, которые нужно сдать)'
  DONT_ENTER_SEMESTER = 'Жмакни кнопку /semester и задай границы семестра'

  WHAT_LAB = 'Какая лаба?'

  ENTER_REMIND_TIME = 'Введите время напоминания (например: понедельник 4.00)'
  REMIND_MENU = "1. Добавить напоминание\n2. Удалить напоминание."
  INCORRECT_TIME = 'Мне кажется ты ввел неправильное время.'
  EMPTY_REMINDERS = 'У тебя нет напоминаний)'
  INCORRECT_REMIND_NUMBER = 'Хм, мне кажется нет такого напоминания'

  def Answer.WHAT_SUBJECT_PASSED(subjects)
    "Какой предмет сдавал?\n\n" + subjects.keys.map.with_index { |value, key| "#{key + 1}. #{value}\n" }.join('')
  end

  def Answer.WHAT_REMIND_PASSED(reminders)
    "Какое напоминаение удалим?\n\n" + reminders.map.with_index do |reminder, index|
      "#{index + 1}. #{Answer.week_day(reminder['days'])} #{reminder['hour']}:00\n"
    end.join('')
  end

  def Answer.WHAT_SUBJECT_REMOVE(subjects)
    "Какой предмет удалим?\n\n" + subjects.keys.map.with_index { |value, key| "#{key + 1}. #{value}\n" }.join('')
  end

  def Answer.HOW_MANY_DAYS_YOU_HAVE(available_time)
    "На все про все у тебя #{available_time} #{Answer.decline(available_time, 'дней', 'день', 'дня')}"
  end

  def Answer.FAIL_AVAILABLE_DAYS(available_time)
    "Мне кажется что ты ввел даты наоборот, я поменяла их местами)\nНа все про все у тебя #{available_time} #{Answer.decline(available_time, 'дней', 'день', 'дня')}"
  end

  def Answer.STATUS(subjects, available_days, start_date)
    elapsed_time = Answer.calc_elapsed_days(start_date)

    "К этому времени у тебя должно быть сдано: \n\n" + subjects.map do |subject_name, subject|
      labs = subject['made_labs']
      labs_count = subject['labs_count']

      made_labs = labs.map.with_index { |value, key| key + 1 if value }.compact
      unmade_labs = labs.map.with_index { |value, key| key + 1 unless value }.compact
      made_labs_count = made_labs.size
      need_made_labs = Answer.in_interval((labs_count * elapsed_time / available_days.to_f).ceil, 0, labs_count)
      unmade_labs = unmade_labs.empty? ? 'Лаб больше не осталось =(' : "Оставшиеся: #{unmade_labs}"

      "#{subject_name}\n   Должно быть сдано: #{need_made_labs}/#{labs_count}\n   Сдано: #{made_labs_count}/#{labs_count}\n   #{unmade_labs}\n\n"
    end.join('')
  end

  private

  def Answer.decline(number, first_dec, sec_dec, third_dec)
    string = number.to_s
    decisive_letter = string[string.length - 1]

    case decisive_letter
      when '0', '5', '6', '7', '8', '9' then return first_dec
      when '1' then return sec_dec
      when '2', '3', '4' then return third_dec
    end
  end

  def Answer.week_day(number)
    days_of_week = %w(Понедельник Вторник Среда Четверг Пятница Суббота Воскресенье)

    days_of_week[number]
  end

  def Answer.calc_elapsed_days(start_date)
    start_date = Date.strptime(start_date, '%d-%m-%Y')
    date_now = Date.strptime(Time.now.strftime('%d-%m-%Y'), '%d-%m-%Y')

    (date_now - start_date).to_i
  end

  def Answer.in_interval(number, min, max)
    return 0 if number < min
    return max if number > max
    number
  end

end