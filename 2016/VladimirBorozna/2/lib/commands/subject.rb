module Bot
  module Command
    # Class for the command - /status
    class Subject < Base
      AVAILABLE_METHODS = %w(subject_name subject_number_works).freeze

      def start
        fail(BotError, "semester_dates_not_found") unless user.semester.present?
        send_message(command_response("subject_name_question"))
      end

      def subject_name
        name = SubjectNameParser.parse(text)
        fail BotError, "semester_dates_not_found" unless user.semester.present?
        fail(BotError, "subject_name_not_uniq")   if     user.subject_exist?(name)

        next_command.update(data: name)
        send_message(command_response("number_works_question"))
      end

      def subject_number_works
        subject_data = {
          name: next_command.data,
          total_number: NumberParser.parse(text),
          accepted_numbers: []
        }

        user.subjects.add(Bot::Subject.create(subject_data))
        send_message(command_response("confirmation"))
      end
    end
  end
end
