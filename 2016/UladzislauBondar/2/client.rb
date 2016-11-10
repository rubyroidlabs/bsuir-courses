require "telegram/bot"
require "redis"
require_relative "../2/libs/message_resolver"
require_relative "../2/libs/command"
require_relative "../2/libs/token"

# Main class for communication with user
class Client
  def initialize
    client.run(Token.get) do |bot|
      bot.listen do |message|
        message_resolver.new(message).resolve
      end
    end
  end

  private

  def client
    Telegram::Bot::Client
  end

  def message_resolver
    MessageResolver
  end
end

Client.new
