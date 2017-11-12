# Initializing DB
class Database
  attr_accessor :redis

  def initialize
    @redis = Redis.new(host: "127.0.0.1", port: 6379)
    # @redis = Redis.new(url: ENV["redis://h:phl40bf5cs3286b1h8pflrroll@ec2-46-51-184-223.eu-west-1.compute.amazonaws.com:8139"])
    hash = std_hash
    @redis.set("public", hash.to_json)
    user_hash = std_user_hash
    @redis.set("users", user_hash.to_json)
    @redis
  end

  def std_hash
    hash = if !@redis.get("public").nil?
             JSON.parse(@redis.get("public")).to_hash
           else {}
           end
    hash["count"] = 0 if hash["count"].nil?
    hash
  end

  def std_user_hash
    hash = if !@redis.get("users").nil?
             JSON.parse(@redis.get("users")).to_hash
           else {}
           end
    hash
  end

  def user_hash
    JSON.parse(@redis.get("users")).to_hash
  end

  def put_user_hash(hash)
    @redis.set("users", hash.to_json)
  end

  def hash
    hash = JSON.parse(@redis.get("public")).to_hash
    hash
  end

  def put_hash(hash)
    @redis.set("public", hash.to_json)
  end
end
