# subject
class SubjectBot < Bot
  def initialize(bot, message)
    super(bot, message)
  end

  def start
    send_text_message("What is the subject?")
    "/subject/save_subject"
  end

  def stop_input?(subjects)
    return false if @message.text != "/stop"
    subjects.delete("__temp")
    send_text_message("OK!")
    true
  end

  def handle(current, subjects)
    return nil if stop_input?(subjects)
    case current[9..-1]
    when "save_subject"
      first_stage(subjects)
    when "save_labs"
      second_stage(subjects)
    end
  end

  def first_stage(subjects)
    if @message.text.start_with?("/")
      send_text_message("What is the subject?")
      return "/subject/save_subject"
    end
    subjects["__temp"] = @message.text
    send_text_message("How many labs?")
    "/subject/save_labs"
  end

  def second_stage(subjects)
    return "/subject/save_labs" if incorrect_number?

    send_text_message("Successfully added")
    subjects[subjects["__temp"]] = { "list" => (1..@message.text.to_i).to_a, "count" => @message.text.to_i }
    subjects.delete("__temp")
    nil
  end

  # send_text_message returns a hash (not nil)
  def incorrect_number?
    if (@message.text =~ /^[\d]+$/).nil?
      send_text_message("How many labs?")
    elsif @message.text.to_i.zero?
      send_text_message("Zero? Are you kidding me? How many labs?")
    elsif @message.text.to_i > 15
      send_text_message("I think, that is too many labs. Please input number again.")
    else
      false
    end
  end
end
