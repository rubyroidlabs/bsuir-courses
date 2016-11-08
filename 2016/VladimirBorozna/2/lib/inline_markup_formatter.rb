# Class is required to generate required keyboard markup
class InlineMarkupFormatter
  SLICE = 1

  class << self
    def markup(ary, callback_name)
      keyboard_buttons = to_keyboad_buttons(ary, callback_name)
      keyboard_buttons << cancel_button
      keyboard(keyboard_buttons.each_slice(SLICE).to_a)
    end

    private

    def cancel_button
      button(I18n.t("buttons.cancel"), "cancel")
    end

    def to_keyboad_buttons(ary, callback_name)
      ary.map do |element|
        Telegram::Bot::Types::InlineKeyboardButton.new(
          text: element,
          callback_data: [callback_name, element].join(";")
        )
      end
    end

    def button(text, data = nil)
      Telegram::Bot::Types::InlineKeyboardButton.new(
        text: text,
        callback_data: data
      )
    end

    def keyboard(buttons)
      Telegram::Bot::Types::InlineKeyboardMarkup.new(
        inline_keyboard: buttons
      )
    end
  end
end
