require_relative 'command.rb'

class Cancel < Command
  def run
    @console.task('CancelTask', @user.name)
    next_command = @user.get_command
    if NEXT_COMMANDS.key?(next_command)
      @user.set_next_command 'waiting'
      case NEXT_COMMANDS[next_command]
      when 'SemesterCommand'
        @user.set_deadline ''
      when 'SubjectCommand'
        @user.delete_subject_if_cancel
      end
      send_message(CANCELED, @message.chat.id)
    else
      send_message(NOTHING_TO_CANCEL, @message.chat.id)
    end
  end
end
