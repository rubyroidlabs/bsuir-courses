# logic for submit command
class SubmitBot < Bot
  def initialize(bot, message)
    super(bot, message)
  end

  def start(subjects)
    if subjects == {}
      send_text_message("First of all, you should fill the /subject")
      return nil
    else
      send_markup_message("What's done?", create_markup(subjects.keys))
    end
    "/submit/1"
  end

  def handle(current, subjects)
    begin
      @message.data
    rescue
      return current
    end

    case current[8]
    when "1"
      return "/submit/1" if @message.data.nil?
      return first_stage(subjects)
    when "2"
      return second_stage(subjects, current)
    end
  end

  def first_stage(subjects)
    if subjects[@message.data]["list"].empty?
      send_text_message("Already done!")
      return nil
    end
    send_markup_message("Choose lab, please.", create_markup(subjects[@message.data]["list"]))
    "/submit/2/#{@message.data}"
  end

  def second_stage(subjects, current)
    if subjects[current[10..-1]]["list"].delete(@message.data.to_i).nil?
      send_text_message("Please, choose the lab")
      return "/submit/2/#{current[10..-1]}"
    end
    send_text_message("Good job, man!")
    nil
  end

  def create_markup(array)
    kb = []
    array.each do |elem|
      kb.push(Telegram::Bot::Types::InlineKeyboardButton.new(text: elem.to_s, callback_data: elem.to_s))
    end
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
  end
end
