require './commands/text_react'
require './models/user'
class Semester_C < Text_React

  def initialize

  end

  def execute_command(user)
    user.user_status.steps_semester['set_ending_date'] = true
    user

  end

  def save_ending_date(user,ending)

    user.semester.ending_date = ending
    curr_time = Time.new
    curr_date = Date.parse curr_time.inspect

    begin
      user.semester.ending_date = Date.parse ending
    rescue ArgumentError
      user.semester.ending_date = ''#handle invalid date
    end

    difference = (user.semester.ending_date - curr_date).to_i unless user.semester.ending_date.is_a? String

    unless  user.semester.ending_date == '' ||  difference < 0
      user.user_status.steps_semester['set_ending_date'] = false
      user.user_status.steps_semester['got_ending_date'] = true
    end
    user

  end

end