require 'redis'

redis = Redis.new(:host => "127.0.0.1", :port => 6379, :db => 15)

# redis.set("mykey", "hello world")
# # => "OK"

# p redis.get("myky")
# # => "hello world"

# p redis.get("user_228861776")

redis.del("user_228861776")