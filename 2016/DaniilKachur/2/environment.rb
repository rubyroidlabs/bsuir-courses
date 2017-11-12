# bot envirponment
module Environment
  def token
    ENV["TELEGRAM_BOT_TOKEN"]
  end

  class << self
    def redis
      @redis ||= Redis.new(url: (ENV["REDISCLOUD_URL"] || "redis://127.0.0.1:6379"))
    end
  end
end
