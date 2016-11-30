require_relative "user"
require_relative "action"

# Class Submit.
class Submission < Action
  def run
    return "You have no subjects." if @user.subjects.length.zero?
    input_text
    increase_phase
    @user.save
    bot_says
  end

  def input_text
    case @user.sys["submission_phase"]
    when 1 then input_subject
    when 2 then input_lab
    end
  end

  def input_subject
    @user.sys["current"] = @text
  end

  def input_lab
    @user.subjects[@user.sys["current"]].delete(@text.to_i)
    delete_if_empty
  end

  def delete_if_empty
    @user.subjects.delete(@user.sys["current"]) if @user.subjects[@user.sys["current"]] == []
  end

  def increase_phase
    @user.sys["submission_phase"] = @user.sys["submission_phase"] >= 2 ? 0 : @user.sys["submission_phase"] + 1
  end

  def bot_says
    case @user.sys["submission_phase"]
    when 1 then "Which subject?"
    when 2 then "Which lab did you pass?"
    when 0 then "OK"
    end
  end
end
