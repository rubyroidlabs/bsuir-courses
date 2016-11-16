module BotCommand
  # semester command
  class Semester < Base
    include Helper::Validators

    def should_start?
      text == "/semester"
    end

    def start
      user.next_bot_command.update(class: self.class, method: :start_date)
      send_message("Когда начинаем учиться?")
    end

    def start_date
      valid_date? "start_date" do |date|
        user.semester[:start] = date
        user.next_bot_command.update(class: self.class, method: :finish_date)
        send_message("Когда дедлайн по лабам?")
      end
    end

    def finish_date
      valid_date? "finish_date" do |date|
        user.semester[:finish] = date
        user.reset_next_bot_command
        send_message("Понял, дней до дедлайна: #{time_left}!")
      end
    end
  end
end
