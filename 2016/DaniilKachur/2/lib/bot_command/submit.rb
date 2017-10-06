module BotCommand
  # submit command
  class Submit < Base
    include Helper::Buttons
    include Helper::Validators

    def should_start?
      text == "/submit"
    end

    def start
      user.next_bot_command.update(class: self.class, method: :select_subject)
      send_message("Что сдавал?", keyboard_buttons(subject_button_list))
    end

    def select_subject
      subject_button_pressed? do
        user.next_bot_command.update(class: self.class, method: :select_lab, data: { subject: text_from_button })
        send_message("Какая лаба?", keyboard_buttons(labs_button_list))
      end
    end

    def select_lab
      lab_button_pressed? do
        user.subjects.update(user.next_bot_command[:data][:subject] => submit_lab(text_from_button))
        user.reset_next_bot_command
        send_message("Красава!")
      end
    end
  end
end
