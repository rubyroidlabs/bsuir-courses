# /status
class BotCommandStatus < BotCommand
  def initialize(update)
    @message = update.message
  end

  def called?
    user = database_load(@message.chat.id)
    @message.text =~ %r{/status} && user[:previous_command].nil?
  rescue
    false
  end

  def semester_is_going_on?(semester_date_start, semester_date_end, time_now)
    if semester_date_start.bigger_than? time_now
      send_message(chat_id: @message.chat.id, text: SEMESTER_NOT_STARTED)
      false
    elsif time_now.bigger_than? semester_date_end
      send_message(chat_id: @message.chat.id, text: SEMESTER_ENDED)
      false
    else
      true
    end
  end

  def passed_labs(user, semester_date_start, semester_date_end, time_now)
    if semester_is_going_on?(semester_date_start, semester_date_end, time_now)
      user[:subjects].each do |k, v|
        count_number_of_passed_labs(semester_date_start, semester_date_end, time_now, k, v)
      end
    end
  end

  def count_number_of_passed_labs(semester_date_start, semester_date_end, time_now, subject, labs)
    lab_passing_interval = semester_date_start.days_left_until(semester_date_end).to_f / labs.size.to_i
    labs_passed = semester_date_start.days_left_until(time_now).to_i / lab_passing_interval
    text = "#{subject} - At this moment #{labs_passed.round} laboratory work(s) should be done."
    send_message(chat_id: @message.chat.id, text: text)
  end

  def calculate_passed_labs(user)
    time_now = FriendlyDate.new(Time.now.strftime("%d.%m.%Y"))
    semester_date_end = FriendlyDate.new(user[:semester][:date_end])
    semester_date_start = FriendlyDate.new(user[:semester][:date_start])
    passed_labs(user, semester_date_start, semester_date_end, time_now)
  end

  def perform
    user = database_load(@message.chat.id)
    if user[:subjects].nil?
      send_message(chat_id: @message.chat.id, text: NO_SUBJECTS)
    elsif user[:semester].nil?
      send_message(chat_id: @message.chat.id, text: NO_SEMESTER)
    else
      calculate_passed_labs(user)
    end
  end
end
