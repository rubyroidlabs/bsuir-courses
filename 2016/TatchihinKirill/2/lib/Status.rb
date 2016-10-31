require_relative 'MainCommand.rb'
require_relative 'calculations.rb'
require 'date'
class StatusCommand < MainCommand
  include Calculations
  class << self

    def calculate_month(semester_finish)
      result = (Date.parse(semester_finish.to_s).mon - Date.today.mon).abs
      result = result
    end
    def case_of_month(month)
      result = 1/2
      case month.to_i
      when 1
        result = 3/4.to_f
      when 2
        result = 1/2.to_f
      when 3
        result = 1/4.to_f
      end
      result
    end
    def calculate_number_of_needed_labs(user_end_semester, count_of_labs)
      coefficient = calculate_month(user_end_semester)
      coefficient = case_of_month(coefficient).to_f
      return (coefficient * count_of_labs.to_f).to_i
    end
    def output_status(user, id, text_of_labs)
      user.subjects.each do |key, value|
        temp = calculate_number_of_needed_labs(user.end_semester, value)
        text_of_labs += "По предмету #{key.to_s.to_s.delete("\n")} у тебя #{value} лаб(На секундочку, у тебя должно быть сдано #{temp} лаб из #{value} на сегодняшний день)\n"
      end
      text_of_labs
    end
    def command(message, bot, text, user, user_end_semester, user_subjects, id)
      text_of_labs = ""
      temp = 1
      if user.subjects.empty?
        super(message, bot, "Чувак, ты всё сдал уже что ли? Красава.")
      else
        text_of_labs += StatusCommand.output_status(user, id,  text_of_labs)
        super(message, bot, text_of_labs)
      end
    end
  end
end
