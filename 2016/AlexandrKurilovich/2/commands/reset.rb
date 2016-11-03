class Reset < Command #:nodoc:
  def message
    @data = { "semester" => 0, "subject" => 0, "submit" => 0, "subjects" => {} }
    @redis.set(@message.chat.id.to_s, @data.to_json)
    @bot.api.sendMessage(chat_id: @message.chat.id, text: "Все данные удалены")
  end
end
