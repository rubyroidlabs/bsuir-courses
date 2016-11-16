module BotCommand
  # submit command
  class Submit < Base
    include Helper::Labs
    include Helper::Buttons

    def should_start?
      text == "/submit"
    end

    def start
      send_message("Что сдавал?", keyboard_buttons(subject_button_list))
      user.next_bot_command.update(class: self.class, method: :select_subject)
    end

    def select_subject
      if not_passed_labs.empty?
        send_message(labs_complete)
      else
        send_message("Какая лаба?", keyboard_buttons(labs_button_list))
        user.next_bot_command.update(class: self.class, method: :select_lab, data: { subject: text })
      end
    end

    def select_lab
      send_message("Красава!")
      user.subjects.update(user.next_bot_command[:data][:subject] => update_labs)
      user.reset_next_bot_command
    end
  end
end
