# Initializing DB
class Database
  def initialize(id)
    user = User.new(id)
    @redis = Redis.new(url: ENV["redis://h:phl40bf5cs3286b1h8pflrroll@ec2-46-51-184-223.eu-west-1.compute.amazonaws.com:8139"])
    hash = get_std_hash(user)
    @redis.set(user.id, hash.to_json)
    @redis
  end

  def get_std_hash(user)
    hash = if !@redis.get(user.id).nil?
             JSON.parse(@redis.get(user.id)).to_hash
             else {}
           end
    hash["subject"] = [{}] if hash["subject"].nil?
    hash["subject_count"] = 0 if hash["subject_count"].nil?
    hash
  end

  def get_hash(id)
    hash = JSON.parse(@redis.get(id)).to_hash
    hash
  end

  def set_hash(hash, id)
    @redis.set(id, hash.to_json)
  end

  attr_accessor :redis
end
