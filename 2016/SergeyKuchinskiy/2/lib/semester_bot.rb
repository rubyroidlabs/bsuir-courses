# logic for semester command
class SemesterBot < Bot
  def initialize(bot, message)
    super(bot, message)
    @month_hash = { "September" => 30, "October" => 31, "November" => 30, "December" => 31, "January" => 31, "February" => 28, "March" => 31, "April" => 30, "May" => 31 }
  end

  def run
    input_month("start")
    "/semester/1"
  end

  def handle(current, semester)
    if @message.text == '/stop'
      semester.clear
      send_text_message("OK!")
      return nil
    end

    case current[10]
    when "1"
      return "/semester/1" unless @month_hash.keys.include?(@message.text)
      semester["month_start"] = @message.text
      input_day(array_of_days(semester["month_start"]), "start")
      "/semester/2"
    when "2"
      return "/semester/2" unless array_of_days(semester["month_start"]).include?(@message.text)
      semester["day_start"] = @message.text
      input_year("start")
      "/semester/3"
    when "3"
      return "/semester/3" unless %w(2016 2017).include?(@message.text)
      semester["year_start"] = @message.text
      input_month("finish")
      "/semester/4"
    when "4"
      return "/semester/4" unless @month_hash.keys.include?(@message.text)
      semester["month_finish"] = @message.text
      input_day(array_of_days(semester["month_finish"]), "finish")
      "/semester/5"
    when "5"
      return "/semester/5" unless array_of_days(semester["month_finish"]).include?(@message.text)
      semester["day_finish"] = @message.text
      input_year("finish")
      "/semester/6"
    when "6"
      return "/semester/6" unless %w(2016 2017).include?(@message.text)
      semester["year_finish"] = @message.text

      semester["start"] = DateTime.parse(semester["month_start"] + " " +
        semester["day_start"] + " " + semester["year_start"])

      semester["finish"] = DateTime.parse(semester["month_finish"] + " " +
        semester["day_finish"] + " " + semester["year_finish"])
      residual = semester["finish"] - semester["start"]
      if residual <= 0
        send_text_message("Incorrect input")
        semester.clear
      else
        send_text_message("There are " + residual.to_i.to_s + " days in your semester")
      end
      nil
    end
  end

  def array_of_days(month)
    days = 1..@month_hash[month]
    days.map(&:to_s)
  end

  def input_year(current)
    answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: %w(2016 2017), one_time_keyboard: true)
    send_markup_message("Choose the #{current} year", answers)
  end

  def input_month(current)
    answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: @month_hash.keys.each_slice(3).to_a, one_time_keyboard: true)
    send_markup_message("Choose the #{current} month", answers)
  end

  def input_day(days, current)
    answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: days.each_slice(6).to_a, one_time_keyboard: true)
    send_markup_message("Choose the #{current} day", answers)
  end
end
