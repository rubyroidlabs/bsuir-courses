# entrypoint
class EntryPoint < Bot
  def initialize(bot, message)
    super(bot, message)
  end

  def run(subjects, semester)
    begin
      @message.text
    rescue
      return nil
    end

    case @message.text
    when '/start'
      return StartBot.new(@bot, @message).run
    when '/semester'
      if semester != {}
        send_text_message('Already defined')
        return nil
      end
      return SemesterBot.new(@bot, @message).run
    when '/subject'
      return SubjectBot.new(@bot, @message).start
    when '/status'
      return StatusBot.new(@bot, @message).run(subjects, semester)
    when '/reset'
      File.delete("UsersData/#{@message.from.id}")
      send_text_message('Successfully deleted')
      return 'reset'
    when '/submit'
      return SubmitBot.new(@bot, @message).start(subjects)
    when '/memes'
      return MemesBot.new(@bot, @message).run
    when '/give_me_memes'
      return StickerBot.new(@bot, @message).run
    else
      send_text_message("#{@message.from.first_name}, I "\
        "have no idea what #{@message.text.inspect} means. Type /start")
      return nil
    end
  end
end
