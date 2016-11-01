require "pp"
require "telegram/bot"
require "date"
require_relative "error"
require_relative "commands"
require_relative "parser"
require_relative "models"
require_relative "dispatcher"
require_relative "configuration"
require_relative "reply_markup_formatter"

module Bot
  class Base #:nodoc:
    attr_reader :webhook_path, :api

    def initialize
      @webhook_path = Bot.configuration.webhook_path
    end

    def call(env)
      return response_error unless request_verified?(env)

      update = get_update(env)
      message = get_message(update)
      from = get_from_info(update)
      user = get_user(from)

      CommandDispatcher.new(user, message).dispatch
      response_ok
    end

    def get_update(env)
      request_body = env["rack.input"].read
      json_data = MultiJson.load(request_body, symbolize_keys: true)
      Telegram::Bot::Types::Update.new(json_data)
    end

    def get_user(from)
      User.find_or_create_by(from)
    end

    def get_message(update)
      update[:message]
    end

    def get_from_info(update)
      update[:message][:from]
    end

    def request_verified?(env)
      webhook_check = env["PATH_INFO"].start_with?(webhook_path)
      webhook_check && env["REQUEST_METHOD"] == "POST"
    end

    def response_error
      [404, {}, ""]
    end

    def response_ok
      [200, {}, ""]
    end
  end
end
