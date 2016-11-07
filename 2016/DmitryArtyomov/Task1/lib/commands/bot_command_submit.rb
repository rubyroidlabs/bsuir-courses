module BotCommand
  # Class for submitting labs command
  class Submit < Base
    def should_start?
      text =~ %r{(/submit|(я сдал|сдал)(а)?)}
    end

    def start
      return unless check_subjects?
      kb = create_keyboard(user.subjects)
      if kb.empty?
        send_message(Responses::SUBM_COOL)
      else
        add_cancel_callback_button(kb)
        sent_msg_id = send_message_inline(Responses::SUBM_SUBJ, markup(kb))
        add_callback('submit-name', sent_msg_id)
      end
    end

    def check_subjects?
      if user.subjects?
        true
      else
        send_message(Responses::NO_SUBJ)
        false
      end
    end

    def create_keyboard(subjects)
      keyboard = []
      subjects.each do |subj, values|
        next if values.count(false).zero?
        keyboard.push(
          Telegram::Bot::Types::InlineKeyboardButton
          .new(text: subj, callback_data: 'submit-name/' + subj)
        )
      end
      keyboard
    end
  end
end
