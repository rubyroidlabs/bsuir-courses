require 'redis'
require 'pry'
require_relative '../lib/parser'

class DataBase
  attr_reader :redis

  def initialize
    @redis = Redis.new
  end

  def set_data(data)
    redis.set('coming_out', data)
  end

  def get_data
    coming_out = redis.get('coming_out')
    if coming_out
      Hash.instance_eval(coming_out)
    else
      coming_out = Parser.new.get_coming_outs
      set_data(coming_out)
      coming_out
    end
  end
end
