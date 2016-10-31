require "telegram/bot"

include Environment

module BotCommand
  # base command class
  class Base
    attr_reader :user, :message, :api

    def initialize(user, message)
      @user = user
      @message = message
      @api = ::Telegram::Bot::Api.new(Environment.token)
    end

    def should_start?
      fail NotImplementedError, "Implementation of Base::should_start? method doesn't exist"
    end

    def start
      fail NotImplementedError, "Implementation of Base::start method doesn't exist"
    end

    protected

    def send_message(text, options = {})
      @api.send_message({ chat_id: user.id, text: text }.update(options))
    end

    def text
      msg = @message["message"]
      msg.nil? ? @message["callback_query"]["data"] : msg["text"]
    end
  end
end
