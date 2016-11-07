require_relative "../commands/command.rb"
require_relative "../constants/answer.rb"

# Class for status command
class Status < Command
  def say(message = "")
    return Answer::DONT_ENTER_SUBJECTS if @subjects.empty?
    return Answer::DONT_ENTER_SEMESTER if @start_date.empty? || @finish_date.empty?

    @dialog_step = 0

    Answer.status(@subjects, @available_days, @start_date)
  end

end
