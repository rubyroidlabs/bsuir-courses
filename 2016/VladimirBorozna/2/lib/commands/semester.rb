module Bot
  module Command
    # Class for the command - /semester
    class Semester < Base
      DAYS_IN_MONTH = 30

      def start
        send_message(command_response("semester_start_question"))
      end

      def semester_start
        next_command.update(data: DateParser.parse(text))
        send_message(command_response("semester_finish_question"))
      end

      def semester_finish
        set_semester_data
        send_message(confiramation_message)
      end

      def select_next_command
        case next_command.method
        when nil
          next_command.set(class_name, "semester_start")
        when "semester_start"
          next_command.set(class_name, "semester_finish")
        when "semester_finish"
          next_command.reset
        end
      end

      private

      def set_semester_data
        start_date  = DateParser.parse(next_command.data)
        finish_date = DateParser.parse(text)
        fail(BotError, "semester_dates_invalid") if start_date >= finish_date

        user.semester.update(start: start_date, finish: finish_date)
      end

      def confiramation_message
        result = command_response("confirmation.main")
        result << left_months
        result << rest_of_days
      end

      def rest_of_days
        number_days = user.semester.number_days % DAYS_IN_MONTH
        return "" unless number_days.positive?

        day_form = translate("day", count: number_days)
        command_response(
          "confirmation.days",
          day_form: day_form,
          number: number_days
        )
      end

      def left_months
        number_months = user.semester.number_days / DAYS_IN_MONTH
        return "" unless number_months.positive?

        month_form = translate("month", count: number_months)
        command_response(
          "confirmation.months",
          number: number_months,
          month_form: month_form
        )
      end
    end
  end
end
