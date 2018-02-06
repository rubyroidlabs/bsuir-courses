require 'redis'
require 'json'

class Database
  attr_accessor :redis

  def initialize
    @redis = Redis.new
  end

  def set_hash(hash)
    @redis.set('data', hash.to_json)
  end

  def get_hash
    JSON.parse(@redis.get('data'))
  end
end
