require_relative "action"
require_relative "user"
require_relative "regulars"
require "time_difference"

MONTHS = [nil, "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"].freeze

# Class Semester.
class Semester < Action
  def run
    input_text
    increase_phase
    @user.save
    bot_says
  end

  def increase_phase
    @user.sys["semester_phase"] = @user.sys["semester_phase"] >= 6 ? 0 : @user.sys["semester_phase"] + 1
  end

  def input_text
    case @user.sys["semester_phase"]
    when 1, 4 then input_year
    when 2, 5 then input_month
    when 3 then input_first_date_end
    when 6 then input_second_date_end
    end
  end

  def input_first_date_end
    @user.sys["start"] = input_day
    @user.sys["current"] = ""
  end

  def input_second_date_end
    @user.sys["end"] = input_day
    @user.sys["current"] = ""
    return unless difference_validation(@user.sys["start"], @user.sys["end"]).nil?
    confirm_dates
  end

  def confirm_dates
    @user.semester["end"] = @user.sys["end"]
    @user.semester["start"] = @user.sys["start"]
  end

  def input_year
    @user.sys["current"] << @text << "-"
  end

  def input_month
    @user.sys["current"] << MONTHS.index(@text).to_s << "-"
  end

  def input_day
    @user.sys["current"] << @text
  end

  def bot_says
    case @user.sys["semester_phase"]
    when 1 then "Choose start year:"
    when 2, 5 then "Choose month:"
    when 3, 6 then "Choose day:"
    when 4 then "Choose finish year:"
    when 0 then print_date(@user.sys["start"], @user.sys["end"])
    end
  end

  def generate_difference(start, finish)
    TimeDifference.between(Date.parse(start), Date.parse(finish))
  end

  def print_date(start, finish)
    option = difference_validation(start, finish)
    if option.zero?
      generate_difference(start, finish).humanize
    else
      incorrect_diff(option)
    end
  end

  def incorrect_diff(option)
    case option
    when 1 then "Too big semester."
    when 2 then "Time travel? Incorrect time interval."
    when 3 then "You are not in semester. Sorry."
    end
  end

  def difference_validation(s, f)
    start = Date.parse(s)
    finish = Date.parse(f)
    difference = generate_difference(s, f)
    if difference.in_each_component[:years] >= 1 then 1
    elsif start > finish then 2
    elsif Date.today < start || Date.today > finish then 3
    else 0
    end
  end
end
