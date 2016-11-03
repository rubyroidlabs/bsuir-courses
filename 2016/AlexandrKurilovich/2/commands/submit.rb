class Submit < Command #:nodoc:
  def message
    @bot.api.sendMessage(chat_id: @message.chat.id, text: "ХЭХЭ")
  end
end
