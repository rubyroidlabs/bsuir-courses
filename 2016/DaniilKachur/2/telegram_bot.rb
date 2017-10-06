require_relative "lib/user"
require_relative "lib/bot_message_dispatcher"
require "./environment"
require "yaml"
require "json"
require "pry"

# this class catch webhook message, create user instance, run dispatcher and send response
class TelegramBot
  def call(env)
    @webhook_message = JSON.parse(env["rack.input"].read)
    dispatcher.new(@webhook_message, user).process
    empty_response
  end

  def empty_response
    ["200", { "Content-Type" => "application/json" }, []]
  end

  def dispatcher
    BotMessageDispatcher
  end

  def from
    if @webhook_message["callback_query"].nil?
      @webhook_message["message"]["from"]
    else
      @webhook_message["callback_query"]["from"]
    end
  end

  def user
    @user = User.find_by(from["id"]) || register_user
  end

  def register_user
    @user = User.find_or_initialize_by(from["id"])
    @user.update_attributes!(from["first_name"], from["last_name"])
    @user
  end
end
