require 'redis'
require 'ferret'
require_relative 'constants'

module Comingout
  class ComingoutDB
    attr_reader :redis, :ferret

    def initialize
      @redis = Redis.new(url: ENV['REDIS_URL']) # url added for heroku.com
      @redis.flushall
      @ferret = Ferret::I.new(key: :id)
      @redis.setnx Comingout::DB_INDEX, 0
    end

    def add(name, uri, note)
      index = @redis.get Comingout::DB_INDEX
      @redis.hset "#{Comingout::DB}:#{index}", 'name', name
      @redis.hset "#{Comingout::DB}:#{index}", 'uri', uri
      @redis.hset "#{Comingout::DB}:#{index}", 'note', note
      prime_names = name.split(/\s/)
      prime_names.each do |each_name|
        @redis.rpush "#{Comingout::DB}:name:#{each_name.downcase}", index
      end
      @ferret << { id: index, name: name }
      @redis.incr Comingout::DB_INDEX
    end

    def addnx(name, uri, note)
      found = @ferret.search(name)
      max_score = found[:max_score]
      return nil if max_score > 1
      add(name, uri, note)
    end

    def get_by_name(name)
      @redis.lrange "#{Comingout::DB}:name:#{name}", 0, -1
    end

    def get_by_index(index)
      @redis.hgetall "#{Comingout::DB}:#{index}"
    end
  end
end
