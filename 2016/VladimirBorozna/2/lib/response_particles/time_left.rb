module Bot
  module Response
    class TimeLeft < Base # :nodoc:
      DAYS_IN_MONTH = 30

      def message
        months_part << days_part
      end

      def days_part
        number_days = user.semester.number_days % DAYS_IN_MONTH
        return "" unless number_days.positive?

        day_form = translate("day", count: number_days)
        translate(
          "response_particles.time_left.days",
          day_form: day_form,
          number: number_days
        )
      end

      def months_part
        number_months = user.semester.number_days / DAYS_IN_MONTH
        return "" unless number_months.positive?

        month_form = translate("month", count: number_months)
        translate(
          "response_particles.time_left.months",
          number: number_months,
          month_form: month_form
        )
      end
    end
  end
end
