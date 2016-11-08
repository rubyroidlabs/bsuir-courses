# /start
class BotCommandStart < BotCommand
  attr_accessor :message

  START_TEXT = "
  Hello! It is LabScheduleBot and it will help you with your labs!
  List of all available commands:
  /semester - set the start date and the end date of the semester
  /subject - add subject and set number of labs on it
  /status - show remaining labs
  /submit - delete labs after you passed them
  /reset - reset ALL (!) data
  ".freeze

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
