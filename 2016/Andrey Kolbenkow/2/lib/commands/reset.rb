
class Reset < Command
  def run
    @console.task('ResetTask', @user.name)
    next_command = @user.get_command
    if next_command.eql?('waiting')
      @user.delete
      send_message(DELETED, @message.chat.id)
    else
      send_message(CANT_DELETE_NOW, @message.chat.id)
    end
  end
end
