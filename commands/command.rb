require_relative "../config"

class Command
  def initialize(bot, message, redis)
    @redis = redis
    @bot = bot
    @message = message
    @data = parse_data
    @subjects = @data["subjects"]
  end

  def parse_data
    data = @redis.get("#{@message.chat.id}")
    if data.nil?
      data = { "semester" => 0, "subject" => 0, "subjects" => {} }
    else
      data = JSON.parse(data)
    end
  end

  def message
  end

  def reset_status
    @data["semester"] = 0
    @data["subject"] = 0
    @redis.set("#{ @message.chat.id }", @data.to_json)
  end
end
