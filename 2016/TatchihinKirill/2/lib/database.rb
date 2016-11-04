class DatabaseWorker
  attr_accessor :redis, :id
  def initialize(id = 1)
    @redis = Redis.new
    user_hash = get_hash_for_user(id)
    @redis.set(id, user_hash.to_json)
    @id = id
  end
  def get_hash_for_user(id)
    if !@redis.get(id).nil?
      user_hash = JSON.parse(@redis.get(id)).to_hash
    else
      user_hash = {}
    end
    user_hash["subject"] = [{}] if user_hash["subject"].nil?
    user_hash["labs_count"] = 0 if user_hash["labs_count"].nil?
    user_hash
  end
  def get_hash(id)
    JSON.parse(@redis.get(id)).to_hash
  end
  def set_hash(hash, id)
    @redis.set(id, hash.to_json)
  end
end
