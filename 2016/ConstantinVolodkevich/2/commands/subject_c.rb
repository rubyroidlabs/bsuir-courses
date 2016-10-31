require './commands/text_react'
require './models/user'
class Subject_C < Text_React

  def execute_command(user)
    user.user_status.steps_subject['save_subject'] = true
    user
  end

  def save_subject(user, text)
    user.user_status.steps_subject['save_subject'] = false
    user.user_status.steps_subject['save_labs'] = true
    user.user_status.steps_subject['relevant_subj'] = text
    user.hash_of_subjects[text] = Subject.new
    user
  end

  def save_labs(user, text)
    hash_of_labs = {}
    (1..text.to_i).each do |i|
      hash_of_labs[i] = Lab.new
    end
    user.user_status.steps_subject['save_labs'] = false
    user.hash_of_subjects[user.user_status.steps_subject['relevant_subj']].hash_of_labs = hash_of_labs
    user.user_status.steps_subject['relevant_subj'] = ''
    user
  end
end