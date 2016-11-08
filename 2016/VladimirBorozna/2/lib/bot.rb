require "pp"
require "telegram/bot"
require "date"
require "json"

module Bot
  class Base #:nodoc:
    attr_reader :webhook_path

    def initialize
      @webhook_path = Bot.configuration.webhook_path
    end

    def call(env)
      return response_error unless request_verified?(env)

      update = update_data(env)
      message = extract_message(update)
      user = user_data(message.from)
      dispatch(user, message)

      response_ok
    end

    def update_data(env)
      request_body = env["rack.input"].read
      json_data = JSON.parse(request_body, symbolize_keys: true)
      Telegram::Bot::Types::Update.new(json_data)
    end

    def extract_message(update)
      update.callback_query || update.message
    end

    def dispatch(user, message)
      case message
      when Telegram::Bot::Types::CallbackQuery
        CallbackDispatcher.new(user, message).dispatch
      when Telegram::Bot::Types::Message
        CommandDispatcher.new(user, message).dispatch
      end
    end

    def user_data(from)
      User.find_or_create_by(from)
    end

    def request_verified?(env)
      env["PATH_INFO"].start_with?(webhook_path) && env["REQUEST_METHOD"] == "POST"
    end

    def response_error
      [404, {}, ""]
    end

    def response_ok
      [200, {}, ""]
    end
  end
end
