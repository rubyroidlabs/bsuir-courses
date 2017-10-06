module Bot
  module Command
    # Class for the command - /status
    class Status < Base
      CHECKMARK = "\u2713".freeze

      def start
        fail(BotError, "semester_dates_not_found") unless user.semester.present?
        fail(BotError, "subjects_not_found")       unless user.subjects_present?

        send_message(response_message)
      end

      private

      def response_message
        result =  semester_time_left << "\n"
        result << Bot::ResponseParticle::SubjectsStatus.new(user).text
        result << conclusion
      end

      def semester_time_left
        result = command_response("semester_time_left_begining")
        result << Bot::ResponseParticle::TimeLeft.new(user).text << "."
      end

      def conclusion
        subjects = user.subjects
        command_response(
          "conclusion",
          accepted_number: subjects.inject(0) { |a, e| a + e.accepted_numbers.size },
          total_number:    subjects.inject(0) { |a, e| a + e.total_number }
        )
      end
    end
  end
end
