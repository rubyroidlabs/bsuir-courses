require 'json'
require 'redis'

# class for user's data.
class User
  attr_accessor :id, :semester, :subjects, :sys
  @@redis = Redis.new(host: "127.0.0.1", port: 6379, db: 15)

  def initialize(id)
    user_hash = @@redis.exists("user_#{id}") ? JSON.parse(@@redis.get("user_#{id}")) :  {}
    @id = id
    @sys = user_hash.fetch("sys", {"semester_phase" => 0, "subjects_phase" => 0, "submission_phase" => 0, "current" => "", "start" => nil})
    @semester = user_hash.fetch("semester", {"start" => nil, "end" => nil})
    @subjects = user_hash.fetch("subjects", {})
  end

  def save
    @@redis.set("user_#{@id}", JSON.generate(itself.to_hash))
  end

  def reset
    @sys = {"semester_phase" => 0, "subjects_phase" => 0, "submission_phase" => 0, "current" => "", "start" => nil}
    @semester = {"start" => nil, "end" => nil}
    @subjects = {}
  end

  def to_hash
    hash = {}
    instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end
end
