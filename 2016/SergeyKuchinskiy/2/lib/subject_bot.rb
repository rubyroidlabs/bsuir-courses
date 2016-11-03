# subject
class SubjectBot < Bot
  def initialize(bot, message)
    super(bot, message)
  end

  def start
    send_text_message("What is the subject?")
    "/subject/1"
  end

  def handle(current, subjects)
    if @message.text == "/stop"
      subjects.delete("__temp")
      send_text_message("OK!")
      return nil
    end

    case current[-1]
    when "1"
      first_stage(subjects)
    when "2"
      second_stage(subjects)
    end
  end

  def first_stage(subjects)
    if @message.text.start_with?("/")
      send_text_message("What is the subject?")
      return "/subject/1"
    end
    subjects["__temp"] = @message.text
    send_text_message("How many labs?")
    "/subject/2"
  end

  def second_stage(subjects)
    return "/subjects/2" unless correct_number?

    send_text_message("Successfully added")
    subjects[subjects["__temp"]] = { "list" => (1..@message.text.to_i).to_a, "count" => @message.text.to_i }
    subjects.delete("__temp")
    nil
  end

  def correct_number?
    if (@message.text =~ /^[\d]+$/).nil?
      send_text_message("How many labs?")
      return false
    elsif @message.text.to_i.zero?
      send_text_message("Zero? Are you kidding me? How many labs?")
      return false
    elsif @message.text.to_i > 15
      send_text_message("I think, that is too many labs. Please input number again.")
      return false
    end
    true
  end
end
