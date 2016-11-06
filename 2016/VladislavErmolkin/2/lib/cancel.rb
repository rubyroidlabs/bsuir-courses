require_relative "action"

# Class Cancel.
class Cancel < Action
  def run
    @user.sys["semester_phase"] = 0
    @user.sys["subjects_phase"] = 0
    @user.sys["submission_phase"] = 0
    @user.save
  end
end
