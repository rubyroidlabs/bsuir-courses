require_relative 'action'
require_relative 'user'
require_relative 'regulars'
require 'time_difference'

class Semester < Action
  def run
    if !text_validation
      sem_fail
      @user.save
      return 'I don\'t know this date.'
    end
    result = case @user.sem["__phase"]
    when 0 then sem_enter
    when 1 then set_start_of_sem
    when 2 then set_end_of_sem
    end
    @user.save
    result
  end

  def sem_fail
    @user.sem["start"] = nil
    @user.sem["end"] = nil
    @user.reset_sem_system_variables
  end

  def sem_enter
    @user.sem["__phase"] += 1
    @user.sem["__is_now?"] = true
    'Start of semester?'
  end

  def set_start_of_sem
    @user.sem["start"] = @text
    @user.sem["__phase"] += 1
    'End of semester?'
  end

  def set_end_of_sem
    @user.sem["end"] = @text
    @user.reset_sem_system_variables
    native_difference generate_difference @user.sem["start"], @user.sem["end"]
  end

  def text_validation
    puts @user.to_hash
    case @user.sem["__phase"]
    when 0 then @text == '/semester'
    when 1..2 then is_date? @text
    end
  end

  def generate_difference(first_date, second_date)
    TimeDifference.between(Time.parse(first_date), Time.parse(second_date)).in_general
  end

  def native_difference(diff)
    month = case diff[:months]
    when 0..1 then 'month' 
    else 'months' 
    end
    week = case diff[:weeks]
    when 0..1 then 'week'
    else 'weeks'
    end
    day = case diff[:days]
    when 0..1 then 'day'
    else 'days'
    end
    "#{diff[:months]} #{month}, #{diff[:weeks]} #{week} & #{diff[:days]} #{day}.\nYou shall not pass. "
  end

  def is_date?(string)
      string.match(DATE_REGEX).nil? ? false : true
  end
end
