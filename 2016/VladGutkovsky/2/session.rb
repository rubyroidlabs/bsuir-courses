require "redis"

# session keeper
module Session
  class << self
    attr_accessor :id, :request
  end
  @redis = Redis.new url: "redis"

  def self.get(key)
    get_absolute "#{@id}:#{key}"
  end

  def self.get_absolute(key)
    if @redis.type(key) == "list"
      @redis.lrange key, 0, -1
    else
      @redis.get key
    end
  end

  def self.set(key, val)
    @redis.set "#{@id}:#{key}", val
  end

  def self.del(key)
    @redis.del "#{@id}:#{key}"
  end

  def self.append(key, val)
    @redis.rpush "#{@id}:#{key}", val
  end

  def self.extend(key, vals)
    vals.each { |v| append key, v }
  end

  def self.remove(key, val, count)
    @redis.lrem "#{@id}:#{key}", count, val
  end

  def self.len(key)
    @redis.llen "#{@id}:#{key}"
  end

  def self.clear
    @redis.keys("#{@id}:*").each { |key| @redis.del(key) }
  end

  def self.clear_absolute
    @redis.keys.each { |key| @redis.del(key) }
  end

  def self.keys
    @redis.keys "#{@id}:*"
  end

  def self.keys_absolute
    @redis.keys
  end
end
