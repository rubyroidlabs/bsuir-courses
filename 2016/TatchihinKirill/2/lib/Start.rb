require_relative 'MainCommand.rb'
class StartCommand < MainCommand
  def initialize(name_of_the_command = '/start')
    @name_of_the_command = name_of_the_command
  end
end
