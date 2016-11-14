# check
class CheckBot < Bot
  def initialize(bot, message, semester)
    super(bot, message)
    @semester = semester
  end

  def check_for_correct_input
    residual = @semester["finish"] - @semester["start"]
    if residual <= 0
      send_text_message("Incorrect input")
      @semester.clear
    else
      send_text_message("There are " + residual.to_i.to_s + " days in your semester")
    end
  end
end
