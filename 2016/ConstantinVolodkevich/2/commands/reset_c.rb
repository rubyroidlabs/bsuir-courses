require '../commands/text_react'
require '../models/user'

class Reset_C < Text_React

  def execute_command(user)
    user.user_status.steps_reset['user_is_sure'] = true
    user
  end

  def reset(id, hash_of_users)
    hash_of_users[id].user_status.steps_reset['user_is_sure'] = false
    hash_of_users.delete(id)
  end
end