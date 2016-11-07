# This class inludes semester date
class Semester < Base
  def send_messages
    date1 = ask_about_semester_date("Когда начинается учёба?")
    date2 = ask_about_semester_date("Когда надо сдать все лабы?")

    if date2 <= date1
      telegram_send_message("Прости дружище, но ты опоздал(")
    else
      add_date_to_redis(date1, date2)
      telegram_send_message("Понял, у тебя есть #{date_day_difference(date1, date2) / 30} месяца и #{date_day_difference(date1, date2) % 30} день ")
    end
  rescue then telegram_send_message("Ты не справился. Попробуй ещё раз.")
  end

  def ask_about_semester_date(question)
    telegram_send_message(question)
    take_new_answer
    until_message_get_date
    Time.parse(messages_array.last)
  end

  def add_date_to_redis(date1, date2)
    user_id = @user_id
    @redis.hmset("#{user_id}-date", "begin", date1)
    @redis.hmset("#{user_id}-date", "end", date2)
    @redis.hmset("#{user_id}-date", "date_differ", date_day_difference(date1, date2))
  end

  def date_day_difference(date1, date2)
    ((date2 - date1) / (3600 * 24)).to_i
  end

  def percent_elements(arr, percent)
    arr.take((arr.size * percent / 100.0).ceil)
  end

  def str_date?(str)
    d, m, y = str.split "."
    Date.valid_date? y.to_i, m.to_i, d.to_i
  end

  def until_message_get_date
    count_try = 10
    count_try.times do
      return if str_date?(messages_array.last)
      telegram_send_message("Введи пожалуйста дату в формате дд.мм.гг ...")
      take_new_answer
    end
    telegram_send_message("У тебя было #{count_try} попыток написать верную дату.")
  end
end
