module Bot
  module Command
    # Class for the command - /semester
    class Semester < Base
      DAYS_IN_MONTH = 30
      AVAILABLE_METHODS = %w(semester_start semester_finish).freeze

      def start
        send_message(command_response("semester_start_question"))
      end

      def semester_start
        next_command.update(data: DateParser.parse(text))
        send_message(command_response("semester_finish_question"))
      end

      def semester_finish
        start_date  = DateParser.parse(next_command.data)
        finish_date = DateParser.parse(text)
        validate_dates(start_date, finish_date)

        user.semester.update(start: start_date, finish: finish_date)
        send_message(confirmation_message)
      end

      private

      def validate_dates(start, finish)
        return unless start >= finish

        next_command.reset
        fail(BotError, "semester_dates_invalid")
      end

      def confirmation_message
        result = command_response("confirmation.begining")
        result << " " << ResponseParticle::TimeLeft.new(user).text << "."
      end
    end
  end
end
