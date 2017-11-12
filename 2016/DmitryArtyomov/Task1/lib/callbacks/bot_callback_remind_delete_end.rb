module BotCallback
  # Class for handling callback of subject removal
  class RemindDeleteEnd < Base
    def should_start?
      callback_data[0] =~ /remind-delete-end/
    end

    def start
      day = callback_data[1]
      ind = callback_data[2]
      deleted = Reminders.new.delete_reminder(user_id, day, ind)
      remove
      edit_inline_message(answer(day, deleted))
    end

    private

    def answer(day, del_remind)
      if del_remind
        Responses::REMINDER_DEL_OK
          .sub('[D]', Responses.const_get('REMINDER_DAY_' + day))
          .sub('[T]', "#{del_remind[0]}:#{del_remind[1].to_s.rjust(2, '0')}")
      else
        Responses::REMINDER_DEL_ERR
      end
    end
  end
end
