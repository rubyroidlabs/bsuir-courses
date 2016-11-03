require "date"
require "time_difference"
require_relative "command"

module Command
  # Semester-command class
  class Semester < Base
    # Flags for getting current step
    START = 0
    FINISH = 1

    def self.name
      "/semester"
    end

    def process
      send_message("Semester starts? (yyyy-mm-dd)")
      @user.save_semester_step(START)
    end

    def process_semester_start
      save_semester_start
      send_message("Semester ends? (yyyy-mm-dd)")
      @user.save_semester_step(FINISH)
    rescue ArgumentError
      send_message("Invalid date. Try again!")
    end

    def process_semester_end
      save_semester_end
      send_message(left_days_message)
      @user.save_command
    rescue ArgumentError
      send_message("Invalid date. Try again!")
    end

    private

    def valid_start?
      (Date.today - @semester_start).positive?
    end

    def valid_end?
      (@semester_end - Date.today).positive?
    end

    def save_semester_start
      @semester_start = Date.parse(text)
      fail ArgumentError unless valid_start?
      @user.save_semester_start(@semester_start)
    end

    def save_semester_end
      @semester_end = Date.parse(text)
      fail ArgumentError unless valid_end?
      @user.save_semester_end(@semester_end)
    end

    def left_days_message
      left_days = left[:days] + (left[:weeks] * 7)
      if (left[:months]).zero?
        "We have #{left[:days]} days left."
      else
        "We have #{left[:months]} months and #{left_days} days left."
      end
    end

    def left
      TimeDifference.between(Date.today, @semester_end).in_general
    end
  end
end
