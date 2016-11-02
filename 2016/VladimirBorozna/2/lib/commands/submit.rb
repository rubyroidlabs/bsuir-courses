module Bot
  module Command
    # Class for the command - /submit
    class Submit < Base
      def start
        fail(BotError, "semester_dates_not_found") unless user.semester_present?
        fail(BotError, "subjects_not_found") unless user.subjects_present?
        send_message(
          response("subject_name_question"),
          reply_markup: subjects_markup
        )
      end

      def subject_name
        name = Parser.parse_subject_name(text)
        fail(BotError, "subject_not_found") unless user.subject_present?(name)

        user.next_command_data(name)
        send_message(
          response("work_number_question"),
          reply_markup: remaining_numbers_markup(name)
        )
      end

      def work_number
        subject = user.subjects.find(name: user.command_data).first
        value = Parser.parse_work_number(text)
        validate_work_number(subject, value)

        subject.update(accepted_numbers: subject.accepted_numbers << value)
        send_message(response("confirmation"))
      end

      def select_next_command
        case user.method
        when nil
          user.next_command(class_name, "subject_name")
        when "subject_name"
          user.next_command(class_name, "work_number")
        when "work_number"
          user.reset_next_command
        end
      end

      private

      def validate_work_number(subject, value)
        check = subject.remaining_numbers.include?(value)
        fail(BotError, "work_number_not_found") unless check
      end

      def remaining_numbers_markup(name)
        subject = user.subjects.find(name: name).first
        numbers = subject.remaining_numbers.map(&:to_s)
        ReplyMarkupFormatter.markup(numbers, 3)
      end

      def subjects_markup
        subject_names = user.subjects.map do |s|
          s.remaining_numbers.size.zero? ? nil : s.name
        end
        ReplyMarkupFormatter.markup(subject_names.compact, 5)
      end
    end
  end
end
