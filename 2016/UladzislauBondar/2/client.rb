require 'telegram/bot'
require 'redis'
require 'yaml'
require_relative '../2/libs/message_resolver'
require_relative '../2/libs/command'

# Main class for communication with user
class Client
  def initialize
    client.run(token) do |bot|
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

  def token
    config = YAML.load_file("config.yaml")
    token = config["config"]["token"]
    token
  end
end

Client.new
