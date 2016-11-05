require '../commands/text_react'
require '../models/user'
require 'timers'

class Reminder_C < Text_React

  def execute_command(user)
    if user.user_status.steps_reminder['remind_on']
      user.user_status.steps_reminder['remind_on'] = false
      $thread.each do |thread|
        thread.kill
      end
    end
    user.user_status.steps_reminder['user_wanna_remind'] = true
    user
  end

  def make_buttons()
    kb = []
    kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: 'every 5 sek', callback_data: '5')
    kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: 'every 10 sek', callback_data: '10')
    kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: 'every day', callback_data: '86400')
    kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: 'every week', callback_data: '604800')
    kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: 'NEVER!', callback_data: 'no')
    kb
  end


end
