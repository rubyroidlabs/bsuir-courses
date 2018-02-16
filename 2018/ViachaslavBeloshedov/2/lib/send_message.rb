class SendMessage
  def send(information, output_message)
    information[:bot].api.send_message(chat_id: information[:message].chat.id, text: output_message)
  end
end
