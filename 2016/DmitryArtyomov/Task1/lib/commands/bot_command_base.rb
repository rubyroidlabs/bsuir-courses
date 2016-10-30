module BotCommand
  # Base class for all user-based input commands
  class Base
    attr_reader :message, :message_handler, :action_handler, :user

    def initialize(message, message_handler, action_handler)
      @message = message
      @message_handler = message_handler
      @action_handler = action_handler
      @user = User.new(user_id)
    end

    def should_start?
      raise NotImplementedError
    end

    def start
      raise NotImplementedError
    end

    protected

    def add_cancel_callback_button(keyboard)
      keyboard.push(
        Telegram::Bot::Types::InlineKeyboardButton
        .new(text: Responses::CANCEL_BUTTON_TEXT, callback_data: 'cancel')
      )
    end

    def send_message(text)
      message_handler.send_message(user_id, text)
    end

    def send_message_inline(text, markup)
      message_handler.send_message_inline(user_id, text, markup)
    end

    def text
      message.text.strip.downcase_rus
    end

    def user_id
      message.chat.id
    end

    def markup(kb)
      Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
    end
  end
end

class String
  def downcase_rus
    rus_down = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'
    rus_up = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ'
    downcase.tr(rus_up, rus_down)
  end
end
