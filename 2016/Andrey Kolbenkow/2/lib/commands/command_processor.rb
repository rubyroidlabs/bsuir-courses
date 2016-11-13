# Dir['commands/*.rb'].each {|file| require file }
require 'unicode_utils'
require_relative 'welcome.rb'
require_relative 'semester.rb'
require_relative 'submit.rb'
require_relative 'cancel.rb'
require_relative 'subject.rb'
require_relative 'command.rb'
require_relative 'status.rb'
require_relative 'reset.rb'

class CommandProcessor
  def initialize
    @commands = COMMANDS
    @next_commands = NEXT_COMMANDS
  end

  def start(message, user)
    case message
    when Telegram::Bot::Types::Message
      run_command(message, user, 'Cancel') if message.text.start_with?('/cancel')
      for_message(message, user)
    when Telegram::Bot::Types::CallbackQuery
      for_query(message, user)
    end
  rescue NoMethodError => ex
    puts ex.message
  end

  def run_command(message, user, task)
    task = Kernel.const_get(task).new message, user
    task.run
  end

  def for_message(message, user)
    command = user.get_command
    if @next_commands.key?(command)
      run_command(message, user, @next_commands[command])
    end
    @commands.each do |k, v|
      run_command(message, user, v) if UnicodeUtils.downcase(message.text).start_with?(k)
    end
  end

  def for_query(message, user)
    user.set_next_command '/query'
    Submit.new(message, user).run
  end
end
