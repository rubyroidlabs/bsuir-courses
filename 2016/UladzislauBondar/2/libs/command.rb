module Command
  # Abstract class for commands
  class Base
    def initialize(message)
      @message = message
      @api = Telegram::Bot::Api.new(token)
      @redis ||= Redis.new
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

    def save_user_command(command = "")
      @redis.hset("users_commands", user_id, command)
    end

    def send_message(text)
      @api.call("sendMessage", chat_id: chat_id, text: text)
    end

    def token
      config = YAML.load_file("config.yaml")
      token = config["config"]["token"]
      token
    end
  end
end
