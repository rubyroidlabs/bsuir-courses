require_relative "../constants/regular.rb"
require_relative "./command.rb"

# Class for remind command
class Remind < Command
  def say(message)
    case @dialog_step
    when 1 then show_menu
    when 2 then add_remove_remind(message)
    when 3 then choose_time(message)
    when 4 then choose_reminder(message)
    end
  end

  def to_hash
      {reminders: @reminders}
  end

  private

  def show_menu
    @dialog_step += 1

    Answer::REMIND_MENU
  end

  def add_remove_remind(message)
    case message.to_i
    when 1 then add_menu
    when 2 then remove_menu
    end
  end

  def add_menu
    return Answer::DONT_ENTER_SUBJECTS if @subjects.empty?
    return Answer::DONT_ENTER_SEMESTER unless @start_date && @finish_date

    @dialog_step = 3

    Answer::ENTER_REMIND_TIME
  end

  def choose_time(message)
    return Answer::INCORRECT_TIME unless Regular::REMIND_TIME =~ message

    time = message.match(Regular::REMIND_TIME).to_a
    days = to_number_week(time[1])
    hour = time[3].to_i

    @reminders << {days: days, hour: hour}
    @dialog_step = 0

    Answer::OK
  end

  def choose_reminder(message)
    return Answer::INCORRECT_REMIND_NUMBER unless message =~ Regular::LABS_COUNT
    return Answer::INCORRECT_REMIND_NUMBER unless check_bound(message.to_i - 1, 0, @reminders.length)

    index = message.to_i - 1

    @reminders.delete_at(index)
    @dialog_step = 0

    Answer::OK
  end

  def remove_menu
    return Answer::EMPTY_REMINDERS if @reminders.empty?

    @dialog_step = 4

    Answer.what_remind_passed(@reminders)
  end

  def to_number_week(day)
    day = day.downcase.to_s #TODO: Разобраться с downcase

    week = %w(понедельник вторник среда четверг пятница суббота воскресенье)
    week_large_letter = %w(Понедельник Вторник Среда Четверг Пятница Суббота Воскресенье)

    one = week.index { |week_day| week_day == day }
    two = week_large_letter.index { |week_day| week_day == day } #Хоть бы никто не увидел o_0

    one || two
  end

end