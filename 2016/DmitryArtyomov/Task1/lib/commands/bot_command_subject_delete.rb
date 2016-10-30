module BotCommand
  # Class for subject deletion command
  class SubjectDelete < Base
    def should_start?
      text =~ %r{/subjectdelete}
    end

    def start
      return unless check_subjects?
      kb = create_keyboard(user.subjects)
      add_cancel_callback_button(kb)
      send_message_inline(Responses::SUBJ_DELETE, markup(kb))
      user.callback = 'subject-delete'
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
      subjects.each_key do |subj|
        keyboard.push(
          Telegram::Bot::Types::InlineKeyboardButton
          .new(text: subj, callback_data: 'subject-delete/' + subj)
        )
      end
      keyboard
    end
  end
end
