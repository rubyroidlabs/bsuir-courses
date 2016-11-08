module Bot
  module Callback
    class SubjectName < Base # :nodoc:
      def should_start?
        data.first =~ /subject_name/
      end

      def start
        name = subject_name
        fail(BotError, "subject_not_found") unless user.subject_exist?(name)

        user.callback.update(data: name, message_id: message.message_id)
        edit_message(
          callback_response("work_number_question"),
          reply_markup: remaining_numbers_markup(name)
        )
      end

      protected

      def subject(name)
        user.subjects.find(name: name).first
      end

      def remaining_numbers_markup(name)
        numbers = subject(name).remaining_numbers.map(&:to_s)
        InlineMarkupFormatter.markup(numbers, "work_number")
      end

      def subject_name
        SubjectNameParser.parse(data[1])
      end
    end
  end
end
