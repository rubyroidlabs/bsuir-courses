# It can send messages
class Reset < Command
  def initialize(bot, message, redis, id)
    super(bot, message)
    hash = {}
    redis.set(id, hash.to_json)
    send_message("Все данные удалены")
  end
end
