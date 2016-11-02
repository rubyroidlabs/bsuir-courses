require_relative 'command'
require 'date'

module Command
  # Semester-command class
  class Semester < Base
    def self.name
      "/semester"
    end

    def process
      send_message("When does this semester end? (yyyy-mm-dd)")
    end

    def process_semester_end
      @semester_end = Date.parse(text)
      raise ArgumentError unless valid_date?
      save_semester_end
      send_message(left_days_message)
      save_user_command
    fail ArgumentError, send_message("Invalid date. Try again!")
    end

    private

    def semester_end
      @semester_end.to_s
    end

    def valid_date?
      today = Date.today
      (@semester_end - today).positive?
    end

    def left_days_message
      left = difference_of_dates
      if (left[:months]).zero?
        "We have #{left[:days]} days left."
      else
        "We have #{left[:months]} months and #{left[:days]} days left."
      end
    end

    def difference_of_dates
      today = Date.today
      difference = {}
      difference[:months] = (@semester_end.year * 12 + @semester_end.month) - (today.year * 12 + today.month)
      difference[:days] = (@semester_end.day - today.day) % 30
      difference
    end

    def save_semester_end
      @redis.hset("users_semester_ends", user_id, semester_end)
    end
  end
end
