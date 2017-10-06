module Bot
  module ResponseParticle
    class TimeLeft < Base # :nodoc:
      DAYS_IN_MONTH = 30

      attr_reader :semester

      def initialize(user)
        @semester = user.semester
      end

      def text
        "#{months_part}#{days_part}"
      end

      def days_part
        number_days = semester.number_days % DAYS_IN_MONTH
        return "" unless number_days.positive?

        translate(
          "response_particles.time_left.days",
          number: number_days,
          day_form: translate("day", count: number_days)
        )
      end

      def months_part
        number_months = semester.number_days / DAYS_IN_MONTH
        return "" unless number_months.positive?

        translate(
          "response_particles.time_left.months",
          number:  number_months,
          month_form: translate("month", count: number_months)
        ) << " "
      end
    end
  end
end
