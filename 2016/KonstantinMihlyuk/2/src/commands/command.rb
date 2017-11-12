# Class for all commands
class Command
  def initialize(user)
    @dialog_step = 1
    @subjects = user["subjects"]
    @start_date = user["start_date"]
    @finish_date = user["finish_date"]
    @available_days = user["available_days"]
    @reminders = user["reminders"]
  end

  def to_hash
    {}
  end

  def dialog_ended
    @dialog_step.zero?
  end

  private

  def check_bound(number, min, max)
    number.to_i >= min && number.to_i < max
  end

  def check_date(message, regular)
    message =~ regular
  end
end
