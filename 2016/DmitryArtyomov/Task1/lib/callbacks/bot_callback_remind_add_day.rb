module BotCallback
  # Class for handling callback of adding day for remind
  class RemindAddDay < Base
    def should_start?
      callback_data[0] =~ /remind-add-day/
    end

    def start
      day = callback_data[1]
      kb = create_keyboard(day)
      add('remind-add-time')
      edit_inline_message(Responses::REMINDER_ADD_TIME, markup(kb))
    end

    private

    def create_keyboard(day)
      keyboard = []
      (0..23).each do |i|
        add_button(keyboard, day, i.to_s << ':00')
      end
      keyboard = keyboard.each_slice(3).to_a
      add_cancel_callback_button(keyboard)
      keyboard
    end

    def add_button(keyboard, day, time)
      keyboard.push(
        Telegram::Bot::Types::InlineKeyboardButton.new(
          text: time,
          callback_data: "remind-add-time/#{day}/#{time}"
        )
      )
    end
  end
end
