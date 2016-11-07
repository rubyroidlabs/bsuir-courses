require_relative "../commands/command.rb"
require_relative "../constants/answer.rb"

class Reset < Command

  def say(message)
    @subjects = {}
    @start_date = ""
    @finish_date = ""

    @dialog_step = 0

    Answer::OK
  end

  def to_hash
    {
        "subjects" => @subjects,
        "start_date" => @start_date,
        "finish_date" => @finish_date
    }
  end

end