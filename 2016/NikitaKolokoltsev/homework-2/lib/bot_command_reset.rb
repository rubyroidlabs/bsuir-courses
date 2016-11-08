# /reset
class BotCommandReset < BotCommand
  def initialize(update)
    @message = update.message
  end

  def called?
    user = database_load(@message.chat.id)
    @message.text =~ %r{/reset} && user[:previous_command].nil?
  rescue
    false
  end

  def perform
    database_save(@message.chat.id, {})
    send_message(chat_id: @message.chat.id, text: "All your data was deleted.")
  end
end
