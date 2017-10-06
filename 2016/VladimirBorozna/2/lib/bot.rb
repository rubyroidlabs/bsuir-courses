require "pp"
require "telegram/bot"
require "date"
require "json"

module Bot
  class Base # :nodoc:
    attr_reader :webhook_path,
                :api,
                :env

    def initialize
      config = Bot.configuration
      @webhook_path = config.webhook_path
      @api = config.api
    end

    def call(env)
      @env = env
      return response_error unless request_verified?

      dispatch
      response_ok
    end

    def dispatch
      data = extract_update_data(update)
      user = get_user(data.from)
      case data
      when Telegram::Bot::Types::CallbackQuery
        CallbackDispatcher.new(api, user, data).dispatch
      when Telegram::Bot::Types::Message
        CommandDispatcher.new(api, user, data).dispatch
      end
    end

    def get_user(from)
      User.find_or_create_by(from.id, from)
    end

    def update
      request_body = env["rack.input"].read
      json_data = JSON.parse(request_body, symbolize_keys: true)
      Telegram::Bot::Types::Update.new(json_data)
    end

    def extract_update_data(update)
      update.callback_query || update.message
    end

    def request_verified?
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
