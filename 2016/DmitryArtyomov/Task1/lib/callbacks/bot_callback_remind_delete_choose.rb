module BotCallback
  # Class for handling callback of remind removal
  class RemindDeleteChoose < Base
    def should_start?
      callback_data[0] =~ /remind-delete-choose/
    end

    def start
      @reminders = Reminders.new
      return if @reminders.user_empty?(user_id)
      kb = create_keyboard
      add_cancel_callback_button(kb)
      edit_inline_message(Responses::REMINDER_DEL_START, markup(kb))
      add('remind-delete-end')
    end

    private

    def create_keyboard
      keyboard = []
      rems = @reminders.get_reminders(user_id)
      rems.each do |day, hours|
        hours.each.with_index do |time, i|
          keyboard.push(generate_key(day, time, i))
        end
      end
      keyboard
    end

    def generate_key(day, time, i)
      text = "#{Responses.const_get("REMINDER_DAY_#{day}")}"\
             " - #{time[0]}:#{time[1].to_s.rjust(2, '0')}\n"

      Telegram::Bot::Types::InlineKeyboardButton.new(
        text: text,
        callback_data: "remind-delete-end/#{day}/#{i}"
      )
    end
  end
end
