require "date"

require_relative "handler"
require_relative "session"
require_relative "utils"

# hello message
class Start < Handler
  def equals?(message)
    message == "/start"
  end

  def answer(from, _message)
    ["Привет, #{from.first_name}.",
     "Я могу в следующие команды:",
     "/start - вывожу это сообщение\n"\
       "/semester - запоминаю даты начала и конца семестра\n"\
       "/subject - запоминаю предмет и количество лаб\n"\
       "/status - вычисляю твой социальный статус\n"\
       "/reset - звоню декану и тебя отчисляют\n"\
       '/submit или "я сдал" - засчитываю твою лабу (но не проверяю)']
  end
end

# semester request dialog
class Semester < ChainHandler
  def initialize
    @monitored_vars = %w(semester_start semester_end)
  end

  def equals?(message)
    message == "/semester"
  end

  def answer(_from, _message)
    Promt.new "Когда начинается семестр?", "semester_start"
  end

  def handle_var(_from, key, value)
    return semester_start value if key == "semester_start"
    return semester_end value if key == "semester_end"
  end

  def semester_start(from)
    Date.parse from
  rescue
    Promt.new "Попробуй дату в формате YYYY-MM-DD", "semester_start"
  else
    Session.set("semester_start", from)
    Promt.new "Когда заканчивается?", "semester_end"
  end

  def semester_end(to)
    Date.parse to
  rescue
    Promt.new "Попробуй дату в формате YYYY-MM-DD", "semester_end"
  else
    delta = (Date.parse(to) - Date.parse(Session.get("semester_start"))).to_i
    Session.set "semester", delta
    Session.del("__promt__")
    "У тебя целых #{delta} дней."
  end
end

# subject request dialog
class Subject < ChainHandler
  def initialize
    @monitored_vars = ["subject", /subject:\d+/]
  end

  def equals?(message)
    message == "/subject"
  end

  def answer(_from, _message)
    Promt.new "Какой предмет?", "subject"
  end

  def handle_var(_from, key, value)
    return subject value if key == "subject"
    return number value if /subject:\d*/ =~ key
  end

  def subject(subj)
    Session.append("subjects", subj)
    Promt.new "Сколько лаб?", "subject:" + (Session.len("subjects") - 1).to_s
  end

  def save_labs(num)
    Session.extend(
      "subject:" + (Session.len("subjects") - 1).to_s,
      [*1..num.to_i]
    )
    Session.set "subject_num:" + (Session.len("subjects") - 1).to_s, num
    Session.del("__promt__")
  end

  def number(num)
    if num.to_i.to_s == num
      save_labs num
      "Я сохранил."
    else
      Promt.new(
        "Попробуй целое число",
        "subject:" + (Session.len("subjects") - 1).to_s
      )
    end
  end
end

# status message
class Status < Handler
  def equals?(message)
    message == "/status"
  end

  # shit starts here. Thank you, Mr. Rubocop
  def answer(_from, _message)
    total_num, all_num, status = Session.get("subjects").
                                         enum_for(:each_with_index).
                                         inject([0, 0, ""]) do |mem, x|
                                          render_current(
                                            mem[0], mem[1], mem[2],
                                            x[0], x[1]
                                          )
                                        end
    render status, total_num, all_num
  end

  def get_labs(i)
    Session.get("subject:#{i}") || []
  end

  def get_num(i)
    Session.get("subject_num:#{i}").to_i
  end

  def render_current(total_num, all_num, status, s, i)
    labs = get_labs i
    num = get_num i
    [
      total_num + labs.length,
      all_num + num,
      status + "#{expectation num} из #{num} лаб по #{s} (#{lablist labs}),"\
      "ты уже сделал #{num - labs.length}\n"
    ]
  end

  def expectation(num)
    num * (
      Date.today - Date.parse(Session.get("semester_start"))
    ).to_i / Session.get("semester").to_i
  end

  def lablist(labs)
    return labs.join(", ") if labs.count.positive?
    "Ты всё сдал"
  end

  def render(status, total_num, all_num)
    [
      "К сегодняшнему дню ты должен сделать:",
      status,
      "Тебе осталось сделать #{total_num} лаб из #{all_num}."
    ]
  end
end

# reset user data
class Reset < Handler
  def equals?(message)
    message == "/reset"
  end

  def answer(_from, _message)
    Session.clear
    "Ты больше не в нашем клубе."
  end
end

# (system) dump all database
class List < Handler
  def equals?(message)
    message == "///list"
  end

  def answer(_from, _message)
    Session.keys.each { |key| p key, Session.get_absolute(key) }
    "///list"
  end
end

# (system) drop database
class ClearAll < Handler
  def equals?(message)
    message == "///clearall"
  end

  def answer(_from, _message)
    Session.clear_absolute
    "///clearall"
  end
end

# lw request dialog
class Submit < Handler
  # keyboard event handler
  class QueryHandler < EventHandler
    def equals?(data)
      /subject:\d+,lab:\d+/ =~ data || /subject:\d+/ =~ data
    end

    def answer(from, data)
      if /subject:\d+,lab:\d+/ =~ data
        lab from, data
      elsif /subject:\d+/ =~ data
        subject from, data
      end
    end

    def subject(_from, data)
      keyboard = Keyboard.new("Какая лаба?")
      Session.get(data).each_with_index do |lab, i|
        keyboard.add_button lab, "#{data},lab:#{i}"
      end
      keyboard
    end

    def lab(_from, data)
      subject, lab = data.split ","
      lab = lab.split(":")[1].to_i
      labs = Session.get(subject)
      if lab.positive? && lab < labs.count
        puts subject, lab, labs[lab]
        puts Session.remove(subject, labs[lab], 1)
        "Мои поздравления."
      else
        "Пожалуйста, не используй клавиатуру более одного раза"
      end
    end
  end

  def equals?(message)
    (message == "/submit") || message.casecmp("я сдал").zero?
  end

  def answer(_from, _message)
    return "Нет предметов для сдачи." if Session.len("subjects") <= 0
    keyboard = Keyboard.new("Что сдал?")
    Session.get("subjects").each_with_index do |subj, i|
      keyboard.add_button subj, "subject:#{i}"
    end
    keyboard
  end
end
