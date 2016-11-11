module Bot
  module Callback
    # Callback takes a subject name from data and sends new markup with numbers of works
    class SubjectName < Base
      def should_start?
        data.first =~ /subject_name/
      end

      def start
        fail(BotError, "subject_not_found") unless user.subject_exist?(subject_name)

        edit_message(
          callback_response("work_number_question"),
          reply_markup: remaining_numbers_markup(subject_name)
        )
      end

      private

      def subject(name)
        user.subjects.find(name: name).first
      end

      def remaining_numbers_markup(name)
        numbers = subject(name).remaining_numbers.map(&:to_s)
        callback_data = numbers.map { |n| "#{name};#{n}" }
        InlineMarkupFormatter.markup(numbers, callback_data, next_callback_name)
      end

      def subject_name
        SubjectNameParser.parse(data[1])
      end

      def next_callback_name
        "work_number"
      end
    end
  end
end
