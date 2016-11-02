require_relative "../config"

class Command #:nodoc:
  def initialize(bot, message, redis)
    @redis = redis
    @bot = bot
    @message = message
    @data = parse_data
    @subjects = @data["subjects"]
  end

  def parse_data
    data = @redis.get(@message.chat.id.to_s)
    return { "semester" => 0, "subject" => 0, "subjects" => {} } if data.nil?
    JSON.parse(data)
  end

  def message
  end

  def reset_status
    @data["semester"] = 0
    @data["subject"] = 0
    @redis.set(@message.chat.id.to_s, @data.to_json)
  end
end
