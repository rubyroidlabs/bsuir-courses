require_relative "../commands/command.rb"
require_relative "../constants/answer.rb"

# Class for submit command
class Submit < Command
  def say(message)
    case @dialog_step
    when 1 then what_passed
    when 2 then what_subject(message)
    when 3 then send_ok(message)
    else 0
    end
  end

  def to_hash
    {
      subjects: @subjects
    }
  end

  def what_passed
    return Answer::DONT_HAVE_SUBJECTS if @subjects.keys.empty?

    @dialog_step += 1

    Answer.what_subject_passed(@subjects)
  end

  def what_subject(message)
    return Answer::INCORRECT_LABS_COUNT unless message =~ Regular::LABS_COUNT
    return Answer::DONT_HAVE_SUBJECT unless check_bound(message.to_i - 1, 0, @subjects.size)

    @subject_key = @subjects.keys[message.to_i - 1]
    @dialog_step += 1

    Answer::WHAT_LAB
  end

  def send_ok(message)
    made_labs = @subjects[@subject_key]["made_labs"]

    return Answer::DONT_HAVE_LABS unless message =~ Regular::LABS_COUNT
    return Answer::DONT_HAVE_LABS unless check_bound(message.to_i - 1, 0, made_labs.size)

    made_labs[message.to_i - 1] = true
    @subjects[@subject_key]["made_labs"] = made_labs
    @dialog_step = 0

    Answer::OK
  end
end
