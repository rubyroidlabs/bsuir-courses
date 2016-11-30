require "redis"
redis = Redis.new(host: "redis-18148.c10.us-east-1-3.ec2.cloud.redislabs.com",
                  port: "18148",
                  password: "111111111111")
keys = redis.keys("*")
keys.each { |key| puts "key:#{key} value:#{redis.get(key)}" }
