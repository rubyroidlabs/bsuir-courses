class Command

  def initialize(user)
    @dialog_step = 1
    @subjects = user["subjects"]
    @start_date = user["start_date"]
    @finish_date = user["finish_date"]
    @available_days = user["available_days"]
    @reminders = user["reminders"]
  end

  def get_dialog_step
    @dialog_step
  end

  def to_hash
    {}
  end

  def dialog_ended
    @dialog_step == 0
  end

  def get_subjects
    @subjects
  end

  def get_start_date
    @start_date
  end

  def get_finish_date
    @finish_date
  end

  def get_available_days
    @available_days
  end

  private

  def check_bound(number, min, max)
    number.to_i >= min && number.to_i < max
  end

  def check_date(message, regular)
    message =~ regular
  end

  def check_available_days(days)
    days > 0
  end

end