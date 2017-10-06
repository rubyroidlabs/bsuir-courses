require_relative 'command.rb'

class SubjectCommand < Command
  def run
    @console.task('SubjectCommand', @user.name)
    next_command = @user.get_command
    case next_command
    when 'waiting'
      first_run
    when '/add_subject'
      add_subject
    when '/add_count_of_labs'
      add_count_of_labs
    end
  end

  def first_run
    send_message(INPUT_SUBJECT_NAME, @message.chat.id)
    @user.set_next_command('/add_subject')
  end

  def add_subject
    if @user.subject_not_exist?(@message.text)
      @user.add_subject(@message.text)
      @user.set_next_command('/add_count_of_labs')
      send_message(COUNT_OF_SUBJECT_LABS, @message.chat.id)
    else
      send_message(SUBJECT_ALREADY_EXIST_INPUT_ANOTHER, @message.chat.id)
    end
  end

  def add_count_of_labs
    if @message.text.to_i.eql?(0) || @message.text.to_i > 20
      send_message(THIS_WILL_NOT_WORK, @message.chat.id)
      re_add
    else
      labs = @message.text
      puts labs
      @user.add_count_of_labs(labs)
      @user.set_next_command('waiting')
      send_message(ACCEPTED, @message.chat.id)
      add_all_labs labs.to_i
    end
  end

  def re_add
    send_message(COUNT_OF_SUBJECT_LABS, @message.chat.id)
    @user.set_next_command('/add_count_of_labs')
  end

  def add_all_labs(labs)
    1.upto(labs) { |lab| @user.add_lab(lab) }
  end
end
