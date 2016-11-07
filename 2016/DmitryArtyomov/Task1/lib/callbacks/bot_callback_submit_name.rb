module BotCallback
  # Class for handling callback of subject name lab submit
  class SubmitName < Base
    def should_start?
      callback_data[0] =~ /submit-name/
    end

    def start
      subj_name = callback_data[1]
      kb = create_keyboard(subj_name)
      add('submit-lab')
      edit_inline_message(Responses::SUBM_LAB, markup(kb))
    end

    def create_keyboard(subj_name)
      keyboard = []
      labs = user.subject(subj_name)
      labs.each_index do |i|
        next if labs[i]
        keyboard.push(create_button(i, subj_name))
      end
      add_cancel_callback_button(keyboard)
      keyboard
    end

    def create_button(lab_number, subj_name)
      Telegram::Bot::Types::InlineKeyboardButton.new(
        text: (lab_number + 1).to_s,
        callback_data: 'submit-lab/' + subj_name + '/' + lab_number.to_s
      )
    end
  end
end
