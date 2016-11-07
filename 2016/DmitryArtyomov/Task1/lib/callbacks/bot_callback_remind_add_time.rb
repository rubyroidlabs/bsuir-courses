module BotCallback
  # Class for handling callback of specifying time for remind day
  class RemindAddTime < Base
    def should_start?
      callback_data[0] =~ /remind-add-time/
    end

    def start
      day = callback_data[1]
      time = callback_data[2]
      res = Reminders.new.add_reminder(user_id, day, time)
      text = res ? Responses::REMINDER_OK : Responses::REMINDER_ERR_EXIST
      remove
      edit_inline_message(answer(text, day, time))
    end

    private

    def answer(text, day, time)
      text
        .sub('[D]', Responses.const_get('REMINDER_DAY_' + day))
        .sub('[T]', time)
    end
  end
end
