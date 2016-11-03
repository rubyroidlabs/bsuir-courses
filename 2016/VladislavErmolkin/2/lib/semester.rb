require_relative 'action'
require_relative 'user'
require_relative 'regulars'
require 'time_difference'

# Class Semester.
class Semester < Action
  def run
    unless text_validation
      sem_fail
      @user.save
      return 'Think you could fool me? Incorrect date.'
    end
    result = case @user.sem['__phase']
             when 0 then sem_enter
             when 1 then set_start_of_sem
             when 2 then set_end_of_sem
             end
    @user.save
    result
  end

  def sem_fail
    @user.sem['start'] = nil
    @user.sem['end'] = nil
    @user.reset_sem_system_variables
  end

  def sem_enter
    @user.sem['__phase'] += 1
    @user.sem['__is_now?'] = true
    'Start of semester?'
  end

  def set_start_of_sem
    @user.sem['start'] = @text.tr!('-', '.')
    @user.sem['__phase'] += 1
    'End of semester?'
  end

  def set_end_of_sem
    @user.sem['end'] = @text.tr!('-', '.')
    @user.reset_sem_system_variables
    native_difference generate_difference @user.sem['start'], @user.sem['end']
  end

  def text_validation
    case @user.sem['__phase']
    when 0 then true
    when 1 then date? @text
    when 2
      if date? @text
        Time.parse(@user.sem['start']) < Time.parse(@text)
      else
        false
      end
    end
  end

  def generate_difference(first_date, second_date)
    TimeDifference.between(Time.parse(first_date), Time.parse(second_date)).in_general
  end

  def native_difference(diff)
    months = plural? 'month', diff[:months]
    weeks = plural? 'week', diff[:weeks]
    days = plural? 'day', diff[:days]

    "#{diff[:months]} #{months}, #{diff[:weeks]} #{weeks} & #{diff[:days]} #{days}."
  end

  def plural?(word, number)
    case number
    when 0..1 then word
    else word + 's'
    end
  end

  def date?(string)
    string.match(DATE_REGEX).nil? ? false : true
  end
end
