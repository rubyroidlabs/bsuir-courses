module Bot
  module Command
    # Class for the command - /status
    class Status < Base
      CHECKMARK = "\u2713".freeze

      def start
        raise BotError, 'semester_dates_not_found' unless user.semester_present?
        raise BotError, 'subjects_not_found' unless user.subjects_present?

        send_message(response_message)
      end

      private

      def response_message
        result =  semester_left_days_message << "\n"
        result << response('required_work_header') << "\n"
        result << subjects_status_message
        result << conclusion_message
      end

      def semester_left_days_message
        left_days_number = (user.semester_finish - Date.today).round
        response(
          'semester_left_days',
          number_days: left_days_number,
          day_form:    translate('day', count: left_days_number)
        )
      end

      def subjects_status_message
        coefficient = calculate_required_coefficient
        user.subjects.inject('') do |result, subject|
          result << subject_status(subject, coefficient) + "\n"
        end
      end

      def subject_status(subject, coefficient)
        required_numbers = subject.required_numbers(coefficient).join(', ')
        required_numbers = CHECKMARK if required_numbers.empty?
        response(
          'subject_status',
          subject_name:     subject.name,
          required_numbers: "-  #{required_numbers}",
          performed_number: subject.accepted_numbers.size,
          total_number:     subject.total_number
        )
      end

      def conclusion_message
        response(
          'conclusion',
          accepted_number: total_number_accepted_works,
          total_number:    total_number_works
        )
      end

      def total_number_works
        user.subjects.inject(0) { |a, e| a + e.total_number }
      end

      def total_number_accepted_works
        user.subjects.inject(0) { |a, e| a + e.accepted_numbers.size }
      end

      def calculate_required_coefficient
        current_date = Date.parse(Time.now.to_s)
        start = user.semester_start
        finish = user.semester_finish
        ((current_date - start) / (finish - start)).to_f
      end
    end
  end
end
