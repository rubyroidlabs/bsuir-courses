module Bot
  module Callback
    class NotificationSetting < Base # :nodoc:
      def should_start?
        data.first =~ %r{notification_setting}
      end

      def start
        fail(BotError, "semester_dates_not_found") unless user.semester.present?
        fail(BotError, "subjects_not_found")       unless user.subjects_present?

        user.notification.update(settings)
        edit_message(callback_response("confirmation"))
      end

      private

      def settings
        { status: true, last_sent: Time.now.utc.to_date }.merge(parse_setting)
      end

      def parse_setting
        case setting
        when %r{^period-(\d+)}
          { period: NumberParser.parse(Regexp.last_match(1)) }
        when %r{^weekday-(\d)}
          { weekday: NumberParser.parse(Regexp.last_match(1)) }
        else
          fail(BotError, "callback_invalid")
        end
      end

      def setting
        data[1]
      end
    end
  end
end
