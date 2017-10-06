require "date"

require_relative "handler"
require_relative "session"
require_relative "utils"
require_relative "dialog"

# hello message
class Start < Handler
  def equals?(message)
    message == "/start"
  end

  def answer(_from, _message)
    START_MESSAGE
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
    Promt.new WHERE_SEMESTER_STARTS, "semester_start"
  end

  def handle_var(_from, key, value)
    return semester_start value if key == "semester_start"
    return semester_end value if key == "semester_end"
  end

  def semester_start(from)
    Date.parse from
  rescue
    Promt.new TRY_VALID_DATE, "semester_start"
  else
    Session.set("semester_start", from)
    Promt.new WHERE_SEMESTER_ENDS, "semester_end"
  end

  def semester_end(to)
    Date.parse to
  rescue
    Promt.new TRY_VALID_DATE, "semester_end"
  else
    delta = (Date.parse(to) - Date.parse(Session.get("semester_start"))).to_i
    Session.set "semester", delta
    Session.del("__promt__")
    [
      Image.new("saved.jpg", "image/jpeg"), YOU_HAVE_DAYS % delta
    ]
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
    Promt.new WHAT_SUBJECT, "subject"
  end

  def handle_var(_from, key, value)
    return subject value if key == "subject"
    return number value if /subject:\d*/ =~ key
  end

  def subject(subj)
    Session.append("subjects", subj)
    Promt.new HOW_MANY_LABS, "subject:" + (Session.len("subjects") - 1).to_s
  end

  def clear(num)
    num.to_i.to_s
  end

  def number(num)
    if num == clear(num)
      Session.set "subject_num:" + (Session.len("subjects") - 1).to_s, num
      Session.del("__promt__")
      Image.new "saved.jpg", "image/jpeg"
    else
      Promt.new(
        TRY_INTEGER, "subject:" + (Session.len("subjects") - 1).to_s
      )
    end
  end
end

# status message
class Status < Handler
  def equals?(message)
    message == "/status"
  end

  def answer(_from, _message)
    status = ""
    Session.get("subjects").each_with_index do |s, i|
      num = Session.get("subject_num:#{i}").to_i
      status += format(STATUS, [expectation(num), num, s])
    end
    [
      TODAY_YOU_MUST + status,
      Image.new("status.jpg", "image/jpeg")
    ]
  end

  def expectation(num)
    num * (
      Date.today -
      Date.parse(Session.get("semester_start"))
    ).to_i / Session.get("semester").to_i
  end
end

# reset user data
class Reset < Handler
  def equals?(message)
    message == "/reset"
  end

  def answer(_from, _message)
    Session.clear
    Image.new "bye.jpg", "image/jpeg"
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
