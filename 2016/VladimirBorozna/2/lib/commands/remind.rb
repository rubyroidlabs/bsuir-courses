module Bot
  module Command
    # Class for the command - /cancel
    class Remind < Base
      def start
        fail(BotError, "semester_dates_not_found") unless user.semester.present?
        fail(BotError, "subjects_not_found") unless user.subjects_present?
        fail(BotError, "all_works_was_submited") unless subject_names.size.positive?

        send_message(
          command_response("remind_question"),
          reply_markup: subjects_markup
        )
      end
    end
  end
end
