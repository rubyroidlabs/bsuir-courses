# This class can reset your date with current user
class Reset < Base
  def reset_redis
    curent_users_set = @redis.keys.select { |k| k.include?(@user_id.to_s) }
    curent_users_set.each { |set| @redis.del(set) }
    telegram_send_message('Данные сброшенны ... ')
  end
end
