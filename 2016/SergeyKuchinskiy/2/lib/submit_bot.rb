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
    "/submit/sub"
  end

  def handle(current, subjects)
    begin
      @message.data
    rescue
      puts "return current"
      return current
    end

    return subject_choose(subjects) if current[8..10] == "sub"
    return lab_choose(subjects, current) if current[8..10] == "lab"
  end

  def subject_choose(subjects)
    return "/submit/sub" if @message.data.nil?
    if subjects[@message.data]["list"].empty?
      send_text_message("Already done!")
      return nil
    end
    send_markup_message("Choose lab, please.", create_markup(subjects[@message.data]["list"]))
    "/submit/lab/#{@message.data}"
  end

  def lab_choose(subjects, current)
    puts "in lab_choose"
    if subjects[current[12..-1]]["list"].delete(@message.data.to_i).nil?
      send_text_message("Please, choose the lab")
      return "/submit/lab/#{current[12..-1]}"
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
