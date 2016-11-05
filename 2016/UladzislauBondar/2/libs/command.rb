module Command
  # Abstract class for commands
  class Base
    def initialize(message)
      @message = message
      @api = Telegram::Bot::Api.new(Token.get)
      @redis = Redis.new
      @user = User.new(user_id)
    end

    def process
      NotImplementedError
    end

    protected

    def text
      @message[:text]
    end

    def chat_id
      @message[:chat][:id]
    end

    def user
      @message[:from]
    end

    def user_id
      @message[:from][:id]
    end

    def telegram_types
      Telegram::Bot::Types
    end

    def send_message(text)
      @api.send_message(chat_id: chat_id, text: text)
    end

    def show_keyboard(text, answers)
      keyboard = telegram_types::ReplyKeyboardMarkup.new(keyboard: answers, one_time_keyboard: true)
      @api.send_message(chat_id: chat_id, text: text, reply_markup: keyboard)
    end

    def hide_keyboard(text)
      keyboard = telegram_types::ReplyKeyboardHide.new(hide_keyboard: true)
      @api.send_message(chat_id: chat_id, text: text, reply_markup: keyboard)
    end
  end
end
