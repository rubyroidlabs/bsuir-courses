require 'telegram/bot'
require './commands/text_react'
require './models/user'

class Submit_C < Text_React

  def execute_command(user)
    user.user_status.steps_submit['check_subject'] = true
    user
  end

  def create_subj_buttons(user)
    kb = []
    user.hash_of_subjects.each do |subj_name, subj|
      kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: subj_name, callback_data: subj_name)
    end
    kb
  end

  def mark_clb_step(user, text)
    user.user_status.steps_submit['check_subject'] = false
    user.user_status.steps_submit['submit_lab'] = true
    user.user_status.steps_submit['relevant_subj'] = text
    user
  end

  def create_labs_buttons(user, text)
    kb = []
    user.hash_of_subjects[user.user_status.steps_submit['relevant_subj']].hash_of_labs.each do |lab_name, lab|
      unless lab.status
        kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: lab_name, callback_data: lab_name)
      end
    end
    kb
  end

  def submit_lab(user, text)
    user.user_status.steps_submit['submit_lab'] = false
    user.hash_of_subjects[user.user_status.steps_submit['relevant_subj']].hash_of_labs[text].status = true
    user
  end

end

