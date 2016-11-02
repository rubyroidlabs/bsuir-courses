class Status < Command
  def message
    if semester?
      @subjects = @data["subjects"]
      @subjects.each do |key, val|
        @bot.api.sendMessage(chat_id: @message.chat.id,
         text: "#{ key } - #{ calc_labs(val) } из #{val} лаб\n")
      end
    end
  end

  private

  def semester?
    if @data["start"].nil? || @data["end"].nil?
      @bot.api.sendMessage(chat_id: @message.chat.id, text: "Ты не ввел границы семеста. /semester чтобы ввести")
      false
    else
      true
    end
  end

  def calc_labs(lab)
    semester_length = (Date.parse(@data["end"])-Date.parse(@data["start"])).to_i
    remaining_days = (Date.parse(@data["end"]) - DateTime.now.to_date).to_i
    ((semester_length-remaining_days).to_f/semester_length*lab.to_i).to_i
  end
end
