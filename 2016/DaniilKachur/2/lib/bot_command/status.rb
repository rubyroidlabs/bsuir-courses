module BotCommand
  # command status
  class Status < Base
    include Helper::Date

    def should_start?
      text == "/status"
    end

    def start
      send_message("К этому времени у тебя должно было быть сдано:\n#{labs_status}")
      user.reset_next_bot_command
    end

    def labs_status
      status = user.subjects.each.inject("") do |status_list, (subject, labs)|
        status_list << "#{subject} - #{(1..labs.count).to_a.join(" ")}\n"
      end
      status.empty? ? status = "Пока что ничего, прям как на каникулах." : status
    end

    def accepted_labs(labs_amount)
      "#{(labs_amount * days_ratio).to_i} из #{labs_amount}"
    end
  end
end
