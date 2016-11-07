require_relative '../commands/command.rb'
require_relative '../constants/answer.rb'
require_relative '../constants/regular.rb'

class Subject_remove < Command

  def say(message)
    case @dialog_step
    when 1 then remove_subject
    when 2 then send_ok(message)
    else 0
    end
  end

  def to_hash
    {
       subjects: @subjects
    }
  end

  private

  def remove_subject
    return Answer::NEED_ADD_SUBJECT if @subjects.empty?

    @dialog_step += 1

    Answer::WHAT_SUBJECT_REMOVE(@subjects)
  end

  def send_ok(subject_number)
    return Answer::INCORRECT_LABS_COUNT unless subject_number =~ Regular::LABS_COUNT
    return Answer::DONT_HAVE_LABS unless check_bound(subject_number.to_i - 1, 0, @subjects.size)

    key = @subjects.keys[subject_number.to_i - 1]
    @subjects.delete(key)

    @dialog_step = 0

    Answer::OK
  end

end
