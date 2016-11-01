module Bot
  module Command
    # Class for the command - /semester
    class Semester < Base
      DAYS_IN_MONTH = 30

      def start
        send_message(response('semester_start_question'))
      end

      def semester_start
        user.next_command_data(Parser.parse_date(text))
        send_message(response('semester_finish_question'))
      end

      def semester_finish
        set_semester_data
        send_message(confiramation_message)
      end

      def select_next_command
        case user.method
        when nil
          user.next_command(class_name, 'semester_start')
        when 'semester_start'
          user.next_command(class_name, 'semester_finish')
        when 'semester_finish'
          user.reset_next_command
        end
      end

      private

      def set_semester_data
        start_date  = Parser.parse_date(user.command_data)
        finish_date = Parser.parse_date(text)
        raise BotError, 'semester_dates_invalid' if start_date >= finish_date

        user.update(
          semester_start: start_date,
          semester_finish: finish_date
        )
      end

      def confiramation_message
        result = response('confirmation.main')
        left_days_number = (user.semester_finish - user.semester_start).round
        result << left_months(left_days_number)
        result << rest_of_days(left_days_number)
      end

      def rest_of_days(left_days_number)
        number_days = left_days_number % DAYS_IN_MONTH
        return '' unless number_days > 0

        day_form = translate('day', count: number_days)
        response(
          'confirmation.days',
          day_form: day_form,
          number: number_days
        )
      end

      def left_months(left_days_number)
        number_months = left_days_number / DAYS_IN_MONTH
        return '' unless number_months > 0

        month_form = translate('month', count: number_months)
        response(
          'confirmation.months',
          number: number_months,
          month_form: month_form
        )
      end
    end
  end
end
