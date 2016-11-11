module Bot
  module Command
    # Class for the command - /submit
    class Submit < Base
      def start
        fail(BotError, "semester_dates_not_found") unless user.semester.present?
        fail(BotError, "subjects_not_found")       unless user.subjects_present?
        fail(BotError, "all_works_was_submited")   if     user.all_submited?

        send_message(
          command_response("subject_name_question"),
          reply_markup: subjects_markup
        )
      end

      private

      def subject_names
        @subject_names ||= user.subjects.map do |subject|
          subject.remaining_numbers.size.zero? ? nil : subject.name
        end
        @subject_names.compact
      end

      def subjects_markup
        InlineMarkupFormatter.markup(subject_names, subject_names, "subject_name")
      end
    end
  end
end
