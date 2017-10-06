# /start
class BotCommandStart < BotCommand
  def initialize(update)
    @message = update.message
  end

  def called?
    user = database_load(@message.chat.id)
    @message.text =~ %r{/start} && user[:previous_command].nil?
  rescue
    false
  end

  def perform
    send_message(chat_id: @message.chat.id, text: START_TEXT)
  end
end
