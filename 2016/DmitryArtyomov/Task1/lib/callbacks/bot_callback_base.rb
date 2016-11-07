module BotCallback
  # Basce class for all callbacks
  class Base
    attr_reader :callback, :message_handler, :user

    def initialize(callback, message_handler)
      @callback = callback
      @message_handler = message_handler
      @user = User.new(user_id)
    end

    def should_start?
      raise NotImplementedError
    end

    def process
      raise NotImplementedError
    end

    protected

    def add(callback_data)
      user.callback = callback_data
      user.callback_msg_id = msg_id
    end

    def remove
      user.callback = nil
      user.callback_msg_id = nil
    end

    def markup(kb)
      Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
    end

    def add_cancel_callback_button(keyboard)
      keyboard.push(
        Telegram::Bot::Types::InlineKeyboardButton
        .new(text: Responses::CANCEL_BUTTON_TEXT, callback_data: 'cancel')
      )
    end

    def callback_data
      callback.data.split('/')
    end

    def msg_id
      callback.message.message_id
    end

    def user_id
      callback.from.id
    end

    def edit_inline_message(text, markup = nil)
      return unless msg_id
      message_handler.edit_inline_message(user_id, msg_id, text, markup)
    end

    def send_message_inline(text, markup)
      message_handler.send_message_inline(user_id, text, markup)
    end
  end
end
