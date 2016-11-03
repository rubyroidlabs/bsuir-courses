require_relative 'user'
require_relative 'action'

# Class Submit.
class Submit < Action
  def run
    unless text_validation
      @user.reset_submit_system_variables
      @user.save
      return 'Incorrect input'
    end
    result = case @user.submit['__phase']
             when 0 then submit_enter
             when 1 then labs_of_subject
             when 2 then submit_lab
             end
    @user.save
    result
  end

  def text_validation
    case @user.submit['__phase']
    when 0 then ['/submit', 'I passed.'].include? @text
    when 1 then @user.subject_items.keys.include? @text
    when 2 then @user.subjects[@user.submit['__current']].include? @text.to_i
    else false
    end
  end

  def button_names
    case @user.submit['__phase']
    when 0 then nil
    when 1 then @user.subject_items.keys
    when 2 then @user.subjects[@text]
    end
  end

  def submit_enter
    @user.submit['__phase'] += 1
    @user.submit['__is_now?'] = true
    if @user.subject_items.length.zero?
      @user.reset_submit_system_variables
      'You have no subjects.'
    else
      'Which subject did you pass?'
    end
  end

  def labs_of_subject
    @user.submit['__phase'] += 1
    @user.submit['__current'] = @text
    'Which lab did you pass?'
  end

  def submit_lab
    @user.subjects[@user.submit['__current']].delete(@text.to_i)
    @user.compact_subjects
    @user.reset_submit_system_variables
    'OK'
  end
end
