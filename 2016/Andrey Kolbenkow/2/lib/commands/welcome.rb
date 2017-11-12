require_relative 'command.rb'
require_relative '../console'
require_relative 'config.rb'

class WelcomingCommand < Command
  def run
    @console.task('WelcomingTask', @user.name)
    send_message(WELCOMINGMESSAGE, @message.chat.id)
  end
end
