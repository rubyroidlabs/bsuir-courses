module BotAction
  # Base class for actions
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

    def send_message(text)
      message_handler.send_message(user_id, text)
    end

    def send_message_inline(text, markup)
      message_handler.send_message(user_id, text, markup)
    end

    def text
      message.text.strip
    end

    def user_id
      message.chat.id
    end

    def action
      user.action
    end

    def action?
      user.action?
    end
  end
end
