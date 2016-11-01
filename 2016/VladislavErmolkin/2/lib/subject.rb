require_relative 'user'
require_relative 'action'

ACTION_REGEX = /^\/\S+$/
NUMBER_REGEX = /^\d+$/


class Subject < Action
  def initialize(user, text)
    super user, text.gsub("\n", "")
  end

  def run
    if !text_validation
      @user.reset_subject_system_variables
      @user.save
      return nil
    end
    result = case @user.subjects["__phase"]
    when 0 then subject_enter
    when 1 then set_subject 
    when 2 then set_number_of_labs
    end
    @user.save
    result
  end

  def subject_enter
    @user.subjects["__phase"] += 1
    @user.subjects["__is_now?"] = true
    'Какой предмет учим?'
  end

  def set_subject
    @user.subjects["__current"] = @text
    @user.subjects["__phase"] += 1
    'Сколько лаб надо сдать?'
  end

  def set_number_of_labs
    @user.subjects[@user.subjects["__current"]] = @text.to_i
    @user.reset_subject_system_variables
    'OK'
  end

  def text_validation
    case @user.subjects["__phase"]
    when 0 then @text == '/subject'
    when 1 then (@text.match(ACTION_REGEX)).nil?
    when 2 then !(@text.match(NUMBER_REGEX)).nil?      
    else false
    end
  end
end