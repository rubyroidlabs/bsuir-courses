require 'redis'
require 'singleton'
require 'json'
require_relative 'secret.rb'

# Class for interaction with Redis cloud server
class DataStorage
  include Singleton

  def initialize
    @redis = Redis.new(
      host: Secret::REDIS_HOST,
      port: Secret::REDIS_PORT,
      password: Secret::REDIS_PASS
    )
  end

  def get_user(user_id)
    data = @redis.get(user_id.to_s)
    data.nil? ? nil : JSON.parse(data)
  end

  def set_user(user_id, user)
    @redis.set(user_id.to_s, user.to_json)
  end

  def delete_user(user_id)
    @redis.del(user_id.to_s)
  end

  def user?(user_id)
    @redis.exists(user_id.to_s)
  end
end
