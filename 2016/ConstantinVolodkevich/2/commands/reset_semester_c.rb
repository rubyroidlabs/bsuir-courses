require '../commands/text_react'
require '../models/user'
class Reset_Semester_C < Text_React

  def execute_command(user)
    user.semester.ending_date = ''
    user.user_status.steps_semester['got_ending_date'] = false
    user
  end
end