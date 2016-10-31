require_relative "lib/user"
require_relative "lib/bot_message_dispatcher"
require "./environment"
require "yaml"
require "json"
require "pry"

# class for processing webhook
class TelegramBot
  def call(env)
    @webhook = JSON.parse(env["rack.input"].read)
    response(dispatcher.new(@webhook, user).process)
  end

  def response(message)
    ["200",
     { "Content-Type" => "application/json" },
     [message.to_json]]
  end

  def dispatcher
    BotMessageDispatcher
  end

  def from
    if @webhook["callback_query"].nil?
      @webhook["message"]["from"]
    else
      @webhook["callback_query"]["from"]
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
