class Status < Command #:nodoc:
  def message
    if semester?
      @bot.api.sendMessage(chat_id: @message.chat.id, text: "Тебе осталось сдать:\n")
      @subjects = @data["subjects"]
      @subjects.each do |key, val|
        @bot.api.sendMessage(chat_id: @message.chat.id, text: "#{key} - #{val.join(", ")}\n")
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
end
