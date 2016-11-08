module Bot
  module Callback
    class WorkNumber < Base # :nodoc:
      def should_start?
        data.first =~ /work_number/
      end

      def start
        verify_callback
        number = NumberParser.parse(data[1])
        validate_work_number(subject, number)
        subject.update(accepted_numbers: subject.accepted_numbers << number)

        edit_message(callback_response("confirmation"))
      end

      private

      def validate_work_number(subject, value)
        check = subject.remaining_numbers.include?(value)
        fail(BotError, "work_number_not_found") unless check
      end

      def subject
        @subject ||= user.subjects.find(name: user.callback.data).first
      end
    end
  end
end
