require_relative 'action'
require_relative 'user'
require_relative 'regulars'
require 'time_difference'

MONTHS = [nil, "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

# Class Semester.
class Semester < Action
  
  def run
    case @user.sys["semester_phase"]
    when 1, 4 then @user.sys["current"] << @text << "-"
    when 2, 5 then @user.sys["current"] << MONTHS.index(@text).to_s << "-"
    when 3 then @user.sys["start"] = @user.sys["current"] << @text
    when 6
     @user.semester["end"] = @user.sys["current"] << @text
     @user.semester["start"] = @user.sys["start"]
    end
    @user.sys["current"] = "" if [3, 6].include? @user.sys["semester_phase"]
    @user.sys["semester_phase"] = @user.sys["semester_phase"] >= 6 ? 0 : @user.sys["semester_phase"] + 1
    @user.save
    bot_says
  end

  def bot_says
    case @user.sys["semester_phase"]
    when 1 then "Choose start year:"
    when 2, 5 then "Choose month:"
    when 3, 6 then "Choose day:"
    when 4 then "Choose finish year:"
    when 0 then print_date
    end
  end

  def print_date
    start = Date.parse(@user.semester["start"])
    finish = Date.parse(@user.semester["end"])
    difference = TimeDifference.between(start, finish)
    if difference.in_each_component[:years] >= 1 then "Too big semester."
    elsif start > finish then "Time travel? Incorrect time interval." 
    elsif Date.today < start || Date.today > finish then "You are not in semester. Sorry."
    else difference.humanize
    end
  end
end
