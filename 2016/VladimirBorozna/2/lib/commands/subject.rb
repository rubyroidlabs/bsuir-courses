module Bot
  module Command
    # Class for the command - /status
    class Subject < Base
      def start
        fail(BotError, "semester_dates_not_found") unless user.semester.present?
        send_message(command_response("subject_name_question"))
      end

      def subject_name
        name = SubjectNameParser.parse(text)
        fail BotError, "semester_dates_not_found" unless user.semester.present?
        fail(BotError, "subject_name_not_uniq") if user.subject_exist?(name)

        user.next_command.update(data: name)
        send_message(command_response("number_works_question"))
      end

      def subject_number_works
        number = NumberParser.parse(text)
        subject_name = user.next_command.data
        subject_data = {
          name: subject_name,
          total_number: number,
          accepted_numbers: []
        }
        user.subjects.add(Bot::Subject.create(subject_data))
        send_message(command_response("confirmation"))
      end

      def select_next_command
        case user.next_command.method
        when nil
          user.next_command.set(class_name, "subject_name")
        when "subject_name"
          user.next_command.set(class_name, "subject_number_works")
        when "subject_number_works"
          user.next_command.reset
        end
      end
    end
  end
end
