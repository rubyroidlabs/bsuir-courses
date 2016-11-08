module Bot
  module Command
    # Class for the command - /status
    class Status < Base
      CHECKMARK = "\u2713".freeze

      def start
        fail(BotError, "semester_dates_not_found") unless user.semester.present?
        fail(BotError, "subjects_not_found") unless user.subjects_present?

        send_message(response_message)
      end

      private

      def response_message
        result =  semester_left_days_message << "\n"
        result << Bot::Response::SubjectsStatus.new(user).message
        result << conclusion_message
      end

      def semester_time_left_message
        result = command_response("semester_time_left_begining")
        result << "#{Bot::Response::TimeLeft.new(user).message}."
      end

      def conclusion_message
        command_response(
          "conclusion",
          accepted_number: user.subjects.inject(0) { |a, e| a + e.accepted_numbers.size },
          total_number:    user.subjects.inject(0) { |a, e| a + e.total_number }
        )
      end
    end
  end
end
