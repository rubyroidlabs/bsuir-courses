require_relative '../commands/command.rb'
require_relative '../constants/answer.rb'

class Subject < Command

  def initialize(user)
    super(user)

    @subject = ''
  end

  def say(message)
    case @dialog_step
    when 1 then teach_subject
    when 2 then labs_count(message)
    when 3 then send_ok(message)
    else 0
    end
  end

  def to_hash
    {
        subjects: @subjects
    }
  end

  private

  def teach_subject
    @dialog_step += 1

    Answer::WHAT_SUBJECT_TEACH
  end

  def labs_count(message)
    return Answer::INCORRECT_SUBJECT_NAME unless message =~ Regular::SUBJECT_NAME

    @subject = message
    @dialog_step += 1

    Answer::HOW_MUCH_LABS_NEED_TAKE
  end

  def send_ok(labs_count)
    return Answer::INCORRECT_LABS_COUNT unless labs_count =~ Regular::LABS_COUNT
    return Answer::INCORRECT_LABS_COUNT unless check_bound(labs_count, 1, 20)

    @subjects[@subject] = {
        'labs_count' => labs_count.to_i,
        'made_labs' => Array.new(labs_count.to_i, false)
    }

    @dialog_step = 0

    Answer::OK
  end

end
