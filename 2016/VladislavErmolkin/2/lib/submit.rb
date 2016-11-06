require_relative 'user'
require_relative 'action'

# Class Submit.
class Submission < Action
  def run
    return "You have no subjects." if @user.subjects.length.zero?
    case @user.sys["submission_phase"]
    when 1 then @user.sys["current"] = @text
    when 2
      @user.subjects[@user.sys["current"]].delete(@text.to_i)
      @user.subjects.delete(@user.sys["current"]) if @user.subjects[@user.sys["current"]] == []
    end
    @user.sys["submission_phase"] = @user.sys["submission_phase"] >= 2 ? 0 : @user.sys["submission_phase"] + 1
    @user.save
    bot_says
  end

  def bot_says
    case @user.sys["submission_phase"]
    when 1 then "Which subject?"
    when 2 then "Which lab did you pass?"
    when 0 then "OK"
    end
  end
end
