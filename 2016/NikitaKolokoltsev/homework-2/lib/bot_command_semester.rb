# /semester
class BotCommandSemester < BotCommand
  def initialize(update)
    @message = update.message
  end

  def called?
    user = database_load(@message.chat.id)
    initialzie_command(user) || continue_command(user)
  rescue
    false
  end

  def continue_command(user)
    calling_commands = %w(semester_date_start_input semester_date_end_input)
    calling_commands.include?(user[:previous_command])
  end

  def initialzie_command(user)
    @message.text =~ %r{/semester} && user[:previous_command].nil?
  end

  def time_left(semester_date_start, semester_date_end)
    time_left = semester_date_end - semester_date_start
    time_left_message = ""
    time_left_message << "Semester length:\n#{time_left[:days]} day(s)\n" if time_left[:days].positive?
    time_left_message << "#{time_left[:months]} month(s)\n" if time_left[:months].positive?
    time_left_message << "#{time_left[:years]} year(s)\n" if time_left[:years].positive?
    time_left_message
  end

  def semester_set(user)
    case user[:previous_command]
    when nil
      remember_command(user)
    when "semester_date_start_input"
      semester_set_date_start(user)
    when "semester_date_end_input"
      semester_set_date_end(user)
    end
    database_save(@message.chat.id, user)
    user[:semester]
  end

  def remember_command(user)
    send_message(chat_id: @message.chat.id, text: SEMESTER_START_DATE_SET)
    user[:previous_command] = "semester_date_start_input"
  end

  def semester_set_date_start(user)
    semester_date_start = FriendlyDate.new(@message.text)
    user[:semester] = { date_start: semester_date_start.to_s }
    send_message(chat_id: @message.chat.id, text: SEMESTER_END_DATE_SET)
    user[:previous_command] = "semester_date_end_input"
  end

  def semester_set_date_end(user)
    semester_date_end = FriendlyDate.new(@message.text)
    fail SemesterDateError unless semester_date_end.bigger_than? FriendlyDate.new(user[:semester][:date_start])
    user[:previous_command] = nil
    user[:semester][:date_end] = semester_date_end.to_s
    # OUTPUT SEMESTER LENGTH!!!
    calculate_semester_time(user[:semester])
  end

  def show_error_message(error)
    send_message(chat_id: @message.chat.id, text: DATE_FORMAT_ERROR) if error.class == DateFormatError
    send_message(chat_id: @message.chat.id, text: SEMESTER_DATE_ERROR) if error.class == SemesterDateError
  end

  def calculate_semester_time(semester)
    semester_date_start = FriendlyDate.new(semester[:date_start])
    semester_date_end = FriendlyDate.new(semester[:date_end])
    send_message(chat_id: @message.chat.id, text: time_left(semester_date_start, semester_date_end))
  end

  def perform
    user = database_load(@message.chat.id)
    semester_set(user)
  rescue DateFormatError, SemesterDateError => error
    show_error_message(error)
    user[:previous_command] = "semester_date_start_input"
    database_save(@message.chat.id, user)
    send_message(chat_id: @message.chat.id, text: SEMESTER_START_DATE_SET)
  end
end
