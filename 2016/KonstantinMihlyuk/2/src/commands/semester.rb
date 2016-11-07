require_relative "./command.rb"
require_relative "../constants/regular.rb"
require_relative "../constants/answer.rb"

# Class for semester command
class Semester < Command
  def initialize(user)
    super(user)

    @start_date = ""
    @finish_date = ""
    @available_days = ""
  end

  def say(message)
    case @dialog_step
    when 1 then begin_dialog
    when 2 then start_learning(message)
    when 3 then finish_learning(message)
    else 0
    end
  end

  def to_hash
    {
      start_date: @start_date,
      finish_date: @finish_date,
      available_days: @available_days
    }
  end

  private

  def begin_dialog
    @dialog_step += 1

    Answer::WHEN_BEGIN_TO_LEARN
  end

  def start_learning(start_date)
    unless check_date(start_date, Regular::DATE)
      return Answer::FAIL_START_LEARNING_DATE
    end

    @dialog_step += 1
    @start_date = start_date

    Answer::WHEN_END_TO_LEARN
  end

  def finish_learning(finish_date)
    return Answer::FAIL_START_LEARNING_DATE unless check_date(finish_date, Regular::DATE)

    available_days = calc_available_days(@start_date, finish_date)

    set_data(finish_date, available_days)
    @dialog_step = 0

    Answer.how_many_days_you_have(@available_days)
  end

  def fail_available_days(finish_date)
    change_dates(finish_date)
    @dialog_step = 0

    Answer.fail_available_days(@available_days)
  end

  def set_data(finish_date, available_days)
    @finish_date = finish_date
    @available_days = available_days
  end

  def change_dates(finish_date)
    @finish_date = @start_date
    @start_date = finish_date
    @available_date = calc_available_days(@start_date, @finish_date)
  end

  def calc_available_days(start_date, finish_date)
    start_date = Date.strptime(start_date, "%d-%m-%Y")
    finish_date = Date.strptime(finish_date, "%d-%m-%Y")

    (finish_date - start_date).to_i
  end
end
