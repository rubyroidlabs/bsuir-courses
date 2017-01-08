class Reset < Command
  def message
    @data = { "semester" => 0, "subject" => 0, "subjects" => {} }
    @redis.set( "#{ @message.chat.id }", @data.to_json )
    @bot.api.sendMessage(chat_id: @message.chat.id, text: "Все данные удалены")
  end
end
