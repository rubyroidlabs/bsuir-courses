require_relative "user"
require_relative "action"
require_relative "regulars"

# Class Subject.
class Subject < Action
  def run
    return bot_says unless text_validation
    input_text
    increase_phase
    @user.save
    bot_says
  end

  def input_text
    case @user.sys["subjects_phase"]
    when 1 then input_subject
    when 2 then input_labs
    end
  end

  def increase_phase
    @user.sys["subjects_phase"] >= 2 ? @user.sys["subjects_phase"] = 0 : @user.sys["subjects_phase"] += 1
  end

  def input_subject
    user.sys["current"] = @text
  end

  def input_labs
    @user.subjects[@user.sys["current"]] = (1..@text.to_i).to_a
    @user.sys["current"] = ""
  end

  def bot_says
    case @user.sys["subjects_phase"]
    when 1 then "Which subject?"
    when 2 then "How many labs?"
    when 0 then "OK"
    end
  end

  def text_validation
    case @user.sys["subjects_phase"]
    when 0 then true
    when 1 then @text.match(ACTION_REGEX).nil?
    when 2 then (!@text.match(NUMBER_REGEX).nil? && (1..20).cover?(@text.to_i))
    else false
    end
  end
end
