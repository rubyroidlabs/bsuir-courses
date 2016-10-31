module BotCommand
  # submit command
  class Submit < Base
    include Helper::Labs
    def should_start?
      text == "/submit"
    end

    def start
      send_message("Что сдавал?", keyboard_buttons(subject_button_list))
      user.next_bot_command.update(class: self.class, method: :select_subject)
    end

    def select_subject
      send_message("Какая лаба?", keyboard_buttons(labs_button_list))
      user.next_bot_command.update(class: self.class, method: :select_lab, data: { subject: text })
    end

    def select_lab
      send_message("Красава!")
      user.subjects.update(subject_name => update_labs)
      user.reset_next_bot_command
    end

    def subject_name
      user.next_bot_command[:data][:subject]
    end

    def keyboard_buttons(button_list)
      { reply_markup: { inline_keyboard: button_list }.to_json }
    end

    def subject_button_list
      user.subjects.keys.each.inject([]) do |buttons, subject|
        buttons << [text: subject.to_s, callback_data: subject.to_s]
      end
    end

    def labs_button_list
      user.subjects[subject_name].each.inject([]) do |buttons, lab|
        buttons << [text: lab.to_s, callback_data: lab.to_s]
      end
    end
  end
end
