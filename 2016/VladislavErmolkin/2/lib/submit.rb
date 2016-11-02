require_relative 'user'
require_relative 'action'

class Submit < Action
  def run
    p @text == '/submit'
    if !text_validation
      @user.reset_submit_system_variables
      @user.save
      return "balhblah. blah"
    end
    result = case @user.submit["__phase"]
    when 0 then submit_enter
    when 1 then get_labs_of_subject
    when 2 then submit_lab
    end
    @user.save
    result
  end

  def text_validation
    case @user.submit["__phase"]
    when 0 then @text == '/submit'
    when 1 then @user.get_subject_items.keys.include? @text
    when 2 then @user.subjects[@user.submit["__current"]].include? @text.to_i
    else false
    end
  end

  def get_button_names
    case @user.submit["__phase"]
    when 0 then nil
    when 1 then @user.get_subject_items.keys
    when 2 then @user.subjects[@text]
    end
  end

  def submit_enter
    @user.submit["__phase"] += 1
    @user.submit["__is_now?"] = true
    @user.get_subject_items.keys
    'Что сдавал?'
  end

  def get_labs_of_subject
    @user.submit["__phase"] += 1
    @user.submit["__current"] = @text
    'Какую лабораторную работу?'
  end

  def submit_lab
    @user.subjects[@user.submit["__current"]].delete(@text.to_i)
    @user.reset_submit_system_variables
    'OK'
  end

end
