require_relative 'command.rb'
class Submit < Command
  def run
    @console.task('SubmitTask', @user.name)
    next_command = @user.get_command
    case next_command
    when 'waiting'
      send_message(WHAT_SUBJECT, @message.chat.id)
      inline_query(@user.get_subjects)
    when '/query'
      @user.set_next_command 'waiting'
      confirm_subject if it_subject?(@message.data)
      confirm_lab     if it_lab?(@message.data)
    end
  end

  def it_subject?(arg)
    arg.to_i.eql?(0)
  end

  def it_lab?(arg)
    !arg.to_i.eql?(0)
  end

  def confirm_subject
    @user.set_submit_subject(@message.data)
    edit_message_text(WHAT_LAB, @message)
    inline_query(@user.labs(@message.data))
  end

  def confirm_lab
    lab = @message.data
    subject = @user.get_submit_subject
    @user.submit(subject, lab)
    edit_message_text(CONGRATULATIONS, @message)
  end
  end
