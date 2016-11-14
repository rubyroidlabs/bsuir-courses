# entrypoint
class EntryPoint < Bot
  def initialize(bot, message)
    super(bot, message)
  end

  def nil_message?
    @message.text
    return false
  rescue
    return true
  end

  def run(subjects, semester)
    return nil if nil_message?
    return info_commands(subjects, semester) if ["/start", "/status", "/memes", "/give_me_memes"].include?(@message.text)
    return input_commands(subjects, semester) if ["/semester", "/subject", "/submit"].include?(@message.text)
    return reset if @message.text == "/reset"
    not_command
  end

  def info_commands(subjects, semester)
    return StartBot.new(@bot, @message).run if @message.text == "/start"
    return StatusBot.new(@bot, @message, subjects, semester).run if @message.text == "/status"
    return memes_commands if ["/give_me_memes", "/memes"].include?(@message.text)
  end

  def memes_commands
    return MemesBot.new(@bot, @message).run if @message.text == "/memes"
    return StickerBot.new(@bot, @message).run if @message.text == "/give_me_memes"
  end

  def input_commands(subjects, semester)
    return SemesterBot.new(@bot, @message, semester).run if @message.text == "/semester"
    return SubjectBot.new(@bot, @message).run if @message.text == "/subject"
    return SubmitBot.new(@bot, @message).start(subjects) if @message.text == "/submit"
  end

  def reset
    File.delete("UsersData/#{@message.from.id}")
    send_text_message("Successfully deleted")
    "reset"
  end

  def not_command
    send_text_message("#{@message.from.first_name}, I "\
        "have no idea what #{@message.text.inspect} means. Type /start")
    nil
  end
end
