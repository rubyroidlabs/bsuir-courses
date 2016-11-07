module BotAction
  # Class for handling input of subject name
  class SubjName < Base
    def should_start?
      user.action[0] =~ /SUBJ_NAME/
    end

    def start
      return unless check_valid?(text)
      form_callback_message(text)
      action_handler.del_action(user)
    end

    private

    def check_valid?(text)
      if text.empty? || text.include?('/') || text.include?("\n")
        action_handler.repeat_action(user)
        false
      elsif user.subject?(text)
        action_handler.del_action(user, Responses::SUBJ_EXIST)
        false
      else
        true
      end
    end

    def form_callback_message(subject_name)
      kb = create_keyboard(subject_name)
      msg_id = send_message_inline(
        Responses::SUBJ_COUNT.sub('[S]', subject_name),
        markup(kb)
      )
      add_callback('subject-add', msg_id)
    end

    def create_keyboard(subj_name)
      keyboard = []
      (1..20).each do |i|
        add_button(keyboard, subj_name, i.to_s)
      end
      keyboard = keyboard.each_slice(5).to_a
      add_cancel_callback_button(keyboard)
      keyboard
    end

    def add_button(keyboard, subj, labs)
      keyboard.push(
        Telegram::Bot::Types::InlineKeyboardButton.new(
          text: labs,
          callback_data: "subject-add/#{subj}/#{labs}"
        )
      )
    end
  end
end
