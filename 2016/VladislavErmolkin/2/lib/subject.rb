require_relative 'user'
require_relative 'action'
require_relative 'regulars'

class Subject < Action
  def run
    if !text_validation
      @user.reset_subject_system_variables
      @user.save
      return 'Think you could fool me? Not today.'
    end
    result = case @user.subjects["__phase"]
    when 0 then subject_enter
    when 1 then set_subject 
    when 2 then set_labs
    end
    @user.save
    result
  end

  def subject_enter
    @user.subjects["__phase"] += 1
    @user.subjects["__is_now?"] = true
    'Which subject?'
  end

  def set_subject
    @user.subjects["__current"] = @text
    @user.subjects["__phase"] += 1
    'How many labs?'
  end

  def set_labs
    @user.subjects[@user.subjects["__current"]] = (1..@text.to_i).to_a
    @user.reset_subject_system_variables
    'Excelent.'
  end

  def text_validation
    case @user.subjects["__phase"]
    when 0 then true
    when 1 then (@text.match(ACTION_REGEX)).nil?
    when 2 then !(@text.match(NUMBER_REGEX)).nil?      
    else false
    end
  end
end
