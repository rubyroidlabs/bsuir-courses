#Resolves commands and messages from user
class MessageResolver
  COMMANDS = [
      Command::Start,
      Command::Semester,
      Command::Subject,
      Command::Status
  ]

  def initialize(text, user)
    @text = text
    @user = user
  end

  def process
    
  end

  private

  def command_start?
    @text =~ %r{/start}
  end
end