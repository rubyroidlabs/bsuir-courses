module BotCommand
  # command subject
  class Subject < Base
    include Helper::Validators

    def should_start?
      text == "/subject"
    end

    def start
      user.next_bot_command.update(class: self.class, method: :add_subject)
      send_message("Какой предмет учим?")
    end

    def add_subject
      valid_subject? do
        user.next_bot_command.update(class: self.class, method: :add_labs, data: { subject: text })
        user.subjects.update(text => [] | old_labs)
        send_message("Сколько лаб надо сдать?")
      end
    end

    def add_labs
      valid_labs? do |labs|
        user.subjects.update(user.next_bot_command[:data][:subject] => labs)
        user.reset_next_bot_command
        send_message("Ок")
      end
    end
  end
end
