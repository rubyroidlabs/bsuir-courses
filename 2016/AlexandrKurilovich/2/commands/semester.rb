class Semester < Command
  def message
    reset_status
    @data["semester"] = 1
    @redis.set( "#{ @message.chat.id }", @data.to_json )
    @bot.api.sendMessage(chat_id: @message.chat.id, text: "Когда начинается семестр?")
  end

  def handler
    unless @data.nil?
      case @data["semester"]
      when 1
        message_end_semester
      when 2
        message_end_of_input
      end
    end
  end

  private

  def message_end_semester
    return unless data_valid?(@message.text)
    @data["semester"] = 2
    @data["start"] = @message.text
    @redis.set("#{ @message.chat.id }", @data.to_json)
    @bot.api.sendMessage(chat_id: @message.chat.id, text: "Когда заканчивается семестр?")
  end

  def message_end_of_input
    return unless data_valid?(@message.text)
    @data["semester"] = 0
    @data["end"] = @message.text
    @redis.set("#{ @message.chat.id }", @data.to_json)
    @bot.api.sendMessage(chat_id: @message.chat.id, text: "У нас #{remaining_days} дня, почан. Прошло #{semester_proc}% семестра.")
  end

  def remaining_days
    (Date.parse(@message.text) - DateTime.now.to_date).to_i
  end

  def semester_proc
    semester_length = (Date.parse(@message.text)-Date.parse(@data["start"])).to_i
    ((semester_length-remaining_days).to_f/semester_length*100).to_i
  end

  def data_valid?(data)
    if (data =~ /(0[1-9]|1[0-9]|2[0-9]|3[01])-(0[1-9]|1[012])-[0-9]{4}/).nil?
      @bot.api.sendMessage(chat_id: @message.chat.id, text: "Что-то ты неправильно ввёл. Пиши в формате DD-MM-YYYY")
      false
    else
      true
    end
  end
end
