MONTH_HASH = { "September" => 30, "October" => 31, "November" => 30, "December" => 31, "January" => 31, "February" => 28, "March" => 31, "April" => 30, "May" => 31 }.freeze
# logic for @semester command
class SemesterBot < Bot
  def initialize(bot, message, semester)
    super(bot, message)
    @semester = semester
  end

  def run
    return nil if stop_input? || already_defined?
    input_month("start")
    "/semester/month_start"
  end

  def handle(current)
    if current[10..-1].include?("start")
      handle_for_start_semester(current)
    else
      handle_for_finish_semester(current)
    end
  end

  def handle_for_start_semester(current)
    return save_month_start if current[10..-1] == "month_start"
    return save_day_start if current[10..-1] == "day_start"
    return save_year_start if current[10..-1] == "year_start"
  end

  def handle_for_finish_semester(current)
    return save_month_finish if current[10..-1] == "month_finish"
    return save_day_finish if current[10..-1] == "day_finish"
    return save_year_finish if current[10..-1] == "year_finish"
  end

  def save_month_start
    return "/semester/month_start" unless MONTH_HASH.keys.include?(@message.text)
    @semester["month_start"] = @message.text
    input_day(array_of_days(@semester["month_start"]), "start")
    "/semester/day_start"
  end

  def save_day_start
    return "/semester/day_start" unless array_of_days(@semester["month_start"]).include?(@message.text)
    @semester["day_start"] = @message.text
    input_year("start")
    "/semester/year_start"
  end

  def save_year_start
    return "/semester/year_start" unless %w(2016 2017).include?(@message.text)
    @semester["year_start"] = @message.text
    input_month("finish")
    "/semester/month_finish"
  end

  def save_month_finish
    return "/semester/month_finish" unless MONTH_HASH.keys.include?(@message.text)
    @semester["month_finish"] = @message.text
    input_day(array_of_days(@semester["month_finish"]), "finish")
    "/semester/day_finish"
  end

  def save_day_finish
    return "/semester/day_finish" unless array_of_days(@semester["month_finish"]).include?(@message.text)
    @semester["day_finish"] = @message.text
    input_year("finish")
    "/semester/year_finish"
  end

  def save_year_finish
    return "/semester/year_finish" unless %w(2016 2017).include?(@message.text)
    @semester["year_finish"] = @message.text
    save_date_start
    save_date_finish
    CheckBot.new(@bot, @message, @semester).check_for_correct_input
    nil
  end

  def save_date_finish
    date_finish = @semester["month_finish"] + " " + @semester["day_finish"] + " " + @semester["year_finish"]
    @semester["finish"] = DateTime.parse(date_finish)
  end

  def save_date_start
    date_start = @semester["month_start"] + " " + @semester["day_start"] + " " + @semester["year_start"]
    @semester["start"] = DateTime.parse(date_start)
  end

  def already_defined?
    return false if @semester["finish"].nil?
    send_text_message("Already defined")
    true
  end

  def stop_input?
    return false if @message.text != "/stop"
    @semester.clear
    send_text_message("OK!")
    true
  end

  def array_of_days(month)
    days = 1..MONTH_HASH[month]
    days.map(&:to_s)
  end

  def input_year(current)
    answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: %w(2016 2017), one_time_keyboard: true)
    send_markup_message("Choose the #{current} year", answers)
  end

  def input_month(current)
    answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: MONTH_HASH.keys.each_slice(3).to_a, one_time_keyboard: true)
    send_markup_message("Choose the #{current} month", answers)
  end

  def input_day(days, current)
    answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: days.each_slice(6).to_a, one_time_keyboard: true)
    send_markup_message("Choose the #{current} day", answers)
  end
end
