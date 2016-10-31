require_relative 'MainCommand.rb'
class SubjectsCommand < MainCommand
  class << self
    def command(message, bot, text, user_action)
      super(message, bot, text)
      user_action = 'subject'
    end
    def make_array_of_subjects(array_of_lines)
      result = []
      array_of_lines.each do |line|
        result.push(line.delete!("Subject:")) if line.include?("Subject:")
      end
      result
    end
    def is_subject_in_hash?(array_of_lines, subject)
      result = false
      array_of_lines.each do |line|
        result = true if line.include?("#{subject}")
      end
      result
    end
    def find_subject_in_file_or_not?(array_of_lines, subject)
      array_of_lines = SubjectsCommand.delete_special_chars(array_of_lines)
      array_of_lines = SubjectsCommand.make_array_of_subjects(array_of_lines)
      result = SubjectsCommand.is_subject_in_hash?(array_of_lines, subject)
      return result
    end
    def open_and_check(id, subject)
      new_subject = true
      if File.exist?("./users/#{id}")
        array_of_lines = IO.readlines("./users/#{id}")
        new_subject = SubjectsCommand.find_subject_in_file_or_not?(array_of_lines, subject)
      end
      new_subject
    end
    def check_correct?(text)
      if text.to_i <= 0 || text.to_i > 40
        return false
      end
      return true
    end
    def end_command(bot, message, id, subject, count_of_labs, user_subjects, user_action)
      if check_correct?(message.text)
        case open_and_check(id, subject)
        when false
          write_subject_to_file(id, subject, count_of_labs, user_subjects)
          bot.api.send_message(chat_id: message.chat.id, text: "Давай сдавай")
        when true
          bot.api.send_message(chat_id: message.chat.id, text: "У тебя уже есть этот предмет в списке сдаваемых")
        end
      else
        bot.api.send_message(chat_id: message.chat.id, text: "Пссс. количество лаб надо вводить числом(или цифрой). Давай по новой")
        user_action = 'count_of_labs'
      end
    end
    def write_strings_for_new_subjects(id_file, subject, count_of_labs, user_subjects)
      id_file.write("Subject:#{subject}\n")
      id_file.write("Count of labs:#{count_of_labs}\n")
      user_subjects[subject.to_sym] = count_of_labs
    end
    def write_subject_to_file(id, subject,count_of_labs, user_subjects)
      id_file = File.open("./users/#{id}", "a+") do |id_file|
        write_strings_for_new_subjects(id_file, subject, count_of_labs, user_subjects)
      end
    end
  end
end
