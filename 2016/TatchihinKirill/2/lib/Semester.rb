require_relative 'MainCommand.rb'
require 'date'
class SemesterCommand < MainCommand
  class << self
    def command(message, bot, text, user_action)
      super(message, bot, text)
      user_action = 'start_semester'
    end
    def calculate_dates(user_end_semester, user_start_semester)
      result = []
      if Date.today.day >= 14
        result.push((Date.parse(user_end_semester.to_s).mon - Date.today.mon - 1).abs)
      else
        result.push((Date.parse(user_end_semester.to_s).mon - Date.today.mon).abs)
      end
      result.push((Date.parse(user_end_semester.to_s).day - Date.parse(user_start_semester.to_s).day).abs)
      result
    end
    def write_semester_to_file(id, user_start_semester, user_end_semester)
      name_of_file = "./users/#{id}"
      File.open(name_of_file, "a+") do |id_file|
        id_file.write("Start of semester:#{user_start_semester}\n")
        id_file.write("End of semester:#{user_end_semester}\n")
      end
    end
    def read_start_semester(id_array)
      result = ""
      id_array.each do |line|
        result = line if line.include?("Start of semester:")
      end
      result = result.delete("Start of semester:")
    end
    def read_end_semester(id_array)
      result = ""
      id_array.each do |line|
        result = line if line.include?("End of semester:")
      end
      result = result.delete("End of semester:")
    end
    def read_semester_from_file(id, user_start_semester, user_end_semester)
      name_of_file = "./users/#{id}"

      File.open(name_of_file, "a+") do |id_file|
        user_start_semester = SemesterCommand.read_start_semester(id_file)
        user_end_semester = SemesterCommand.read_end_semester(id_file)
      end
    end
    def is_start_in_file?(id_file)
      result = false
      id_file.each do |line|
        result = true if line.include?("Start of semester:")
      end
      result
    end
    def is_end_in_file?(id_file)
      result = false
      id_file.each do |line|
        result = true if line.include?("End of semester:")
      end
      result
    end
    def open_file(id)
      result_file = File.open("./users/#{id}", "a+")
      array_of_lines = result_file.readlines
      result_file.close
      array_of_lines
    end
    def check_client(id, user_start_semester, user_end_semester, user_action)
      id_file = SemesterCommand.open_file(id)
      should_write = SemesterCommand.is_end_in_file?(id_file) && SemesterCommand.is_start_in_file?(id_file)
      case should_write
      when false
        SemesterCommand.write_semester_to_file(id, user_start_semester, user_end_semester)
      when true
        SemesterCommand.read_semester_from_file(id, user_start_semester, user_end_semester)
      end
    end
    def output_month(date)
      result = ""
      case date
      when 1
        result = "месяц"
      when 2..4
        result = "месяца"
      end
      result
    end
    def output_day(date)
      result = ""
      case date
      when 1, 21, 31
        result = "день"
      when 2..4, 22..24
        result = "дня"
      when 5..20, 25..30
        result = "дней"
      end
      result
    end
    def semester(message, bot, user, id, user_action)
      if !user.semester_calculate(bot, message, message.text, user_action)
        SemesterCommand.check_client(id, user.start_semester, user.end_semester, user_action)
        date = SemesterCommand.calculate_dates(user.end_semester, user.start_semester)
        bot.api.send_message(chat_id: message.chat.id, text: "ВОТ БАЛИН, У нас всего #{date[0]} #{output_month(date[0])}   и #{date[1]}  #{output_day(date[1])}")
      end
    end
  end
end
