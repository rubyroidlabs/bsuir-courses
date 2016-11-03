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

    def send_message(text)
      @api.call("sendMessage", chat_id: chat_id, text: text)
    end
  end
end
