require_relative 'command.rb'
class Status < Command
  attr_accessor :status_text

  def run
    @console.task('StatusTask', @user.name)
    next_command = @user.get_command
    subjects = @user.get_subjects
    subjects.each do |subject|
      @status_text = "#{@status_text}\n" + subject + ' ' + @user.labs(subject).join(' ')
    end
    if @status_text.eql?(nil)
      send_message(TALES_NOT_EXIST, @message.chat.id)
    else
      @status_text = [CURRENT_STATE, @status_text, I_BELIEVE_IN_YOU].join("\n")
      send_message(@status_text, @message.chat.id)
    end
  end
end
