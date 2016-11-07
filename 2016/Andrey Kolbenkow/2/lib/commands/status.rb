require_relative 'command.rb'
class Status < Command
  attr_accessor :status_text

  def run
    @console.task('StatusTask', @user.name)
    next_command = @user.get_command
    subjects = @user.get_subjects
    subjects.each do |subject|
      @status_text = "#{@status_text}\n" + subject + ' ' + @user.labs(subject).to_s
    end
    if @status_text.eql?(nil)
      send_message(TALES_NOT_EXIST, @message.chat.id)
    else
      send_message(@status_text, @message.chat.id)
    end
  end
end
