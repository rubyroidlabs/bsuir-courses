module BotCommand
  # command status
  class Status < Base
    include Helper::Date
    include Helper::Labs

    def should_start?
      text == "/status"
    end

    def start
      user.reset_next_bot_command
      send_message("К сегодняшнему дню тебе осталось сдать:\n#{labs_status}")
    end

    def labs_status
      status = user.subjects.each.inject("") do |status_list, (subject, labs)|
        not_passed_labs(labs).empty? ? status_list : status_list << "#{subject} - #{not_passed_labs(labs).join(' ')} из #{labs.count}\n"
        status_list
      end
      status.empty? ? "Красава, все лабы сдал, или сейчас каникулы." : status
    end
  end
end
