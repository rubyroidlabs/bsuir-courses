module Bot
  module Command
    # Class for the command - /cancel
    class Remind < Base
      CALLBACK_DATA = %w(
        period-1
        period-2
        period-3
        weekday-1
      ).freeze

      def start
        fail(BotError, "semester_dates_not_found") unless user.semester.present?
        fail(BotError, "subjects_not_found")       unless user.subjects_present?
        fail(BotError, "all_works_was_submited")   if     user.all_submited?

        message = command_response("remind_question")
        send_message(message, reply_markup: remind_markup)
      end

      private

      def remind_markup
        periods = command_response("period_names")
        InlineMarkupFormatter.markup(periods, CALLBACK_DATA, callback_name)
      end

      def callback_name
        "notification_setting"
      end
    end
  end
end
