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
      chat_id = callback.from.id
      msg_id = callback.message.message_id
      message_handler.edit_inline_message(chat_id, msg_id, text, markup)
    end
  end
end
