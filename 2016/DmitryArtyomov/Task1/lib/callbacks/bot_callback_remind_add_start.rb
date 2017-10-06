module BotCallback
  # Class for handling callback of adding remind
  class RemindAddStart < Base
    def should_start?
      callback_data[0] =~ /remind-add-start/
    end

    def start
      kb = create_keyboard
      edit_inline_message(
        Responses::REMINDER_ADD_START,
        markup(kb)
      )
      add('remind-add-day')
    end

    private

    def create_keyboard
      keyboard = []
      (0..9).each do |i|
        add_button(
          keyboard,
          Responses.const_get('REMINDER_DAY_' + i.to_s),
          i.to_s
        )
      end
      add_cancel_callback_button(keyboard)
      keyboard
    end

    def add_button(keyboard, text, cb_data)
      keyboard.push(
        Telegram::Bot::Types::InlineKeyboardButton
        .new(text: text, callback_data: 'remind-add-day/' + cb_data)
      )
    end
  end
end
