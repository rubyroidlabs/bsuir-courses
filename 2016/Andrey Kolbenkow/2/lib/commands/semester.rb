require_relative 'command.rb'

class SemesterCommand < Command
  def run
    @console.task('SemesterCommand', @user.name)
    case @user.get_command
    when 'waiting'
      @user.dead_line_executed? ? reload_dialog : first_run
    when '/year_input'
      year_input
    when '/month_input'
      month_input
    when '/day_input'
      day_input
    when '/reload_deadline'
      reload
    end
  end

  def first_run
    send_message(WHEN_DEADLINE, @message.chat.id)
    @user.set_next_command '/year_input'
    send_message(INPUT_YEAR, @message.chat.id, hide_year_keyboard)
  end

  def year_input
    @user.set_deadline(@message.text)
    @user.set_next_command '/month_input'
    send_message(INPUT_MONTH, @message.chat.id, hide_month_keyboard)
  end

  def month_input
    dead_line_date = [@message.text, @user.get_deadline[0][0]].reject(&nil).to_a.join('.')
    @user.set_deadline(dead_line_date)
    @user.set_next_command '/day_input'
    send_message(INPUT_DAY, @message.chat.id, hide_day_keyboard)
  end

  def day_input
    dead_line_date = [@message.text, @user.get_deadline[0][0]].reject(&nil).to_a.join('.')
    @user.set_deadline(dead_line_date)
    @user.set_next_command('waiting')
    @user.set_executed 'true'
    days_left(dead_line_date)
  end

  def reload_dialog
    send_message(DEADLINE_ALREADY_EXIST, @message.chat.id, side_yes_no_keyboard)
    @user.set_next_command('/reload_deadline')
  end

  def reload
    if @message.text.start_with?('Yes')
      @user.set_next_command('waiting')
      @user.set_executed('false')
      @user.set_deadline(EMPTY_STRING)
      SemesterCommand.new(@message, @user).run
    else
      send_message(HOW_YOU_WISH, @message.chat.id)
      @user.set_next_command('waiting')
    end
  end

  def days_left(dead_line)
    days = Date.parse(dead_line).mjd - Date.parse(Time.now.to_s).mjd
    send_message("На все у тебя осталось #{days}дн 😔", @message.chat.id)
  rescue ArgumentError
    send_message(UNCORRECT_DATE, @message.chat.id)
    @user.set_deadline EMPTY_STRING
    @user.set_executed 'false'
  end
end
