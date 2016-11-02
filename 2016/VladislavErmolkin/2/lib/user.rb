require 'json'
require 'redis'

class User
  attr_accessor :id, :sem, :subjects, :submit
  @@redis = Redis.new(:host => "127.0.0.1", :port => 6379, :db => 15)

  def initialize(id)
    @id = id
    user_hash = if @@redis.exists "user_#{id}"
      JSON.parse(@@redis.get("user_#{id}"))
    else
      {}
    end
    set_attrs user_hash
  end

  def set_attrs(params)
    set_sem_attrs params
    set_subject_attrs params
    set_submit_attrs params
  end

  def set_submit_attrs(params)
    @submit = params.fetch('submit', Hash.new)
    reset_submit_system_variables if @submit.empty?
  end

  def set_sem_attrs(params)
    @sem = params.fetch('sem', Hash.new)
    if @sem.empty?
      @sem["start"] = nil
      @sem["end"] = nil
      reset_sem_system_variables
    end
  end

  def set_subject_attrs(params)
    @subjects = params.fetch('subjects', Hash.new)
    reset_subject_system_variables if @subjects.empty? 
  end

  def reset_sem_system_variables
    @sem["__is_now?"] = false
    @sem["__phase"] = 0
  end

  def reset_subject_system_variables
    @subjects["__is_now?"] = false
    @subjects["__phase"] = 0
    @subjects["__current"] = nil
  end

  def reset_submit_system_variables
    @submit["__is_now?"] = false
    @submit["__phase"] = 0
    @submit["__current"] = nil
  end

  def get_subject_items
    @subjects.select { |key, value| key[0...2] != "__"}
  end

  def save
    @@redis.set "user_#{@id}", JSON.generate(itself.to_hash)
    puts @@redis.get "user_#{@id}"
  end

  def reset
    set_sem_attrs({})
    set_subject_attrs({})
  end

  def to_hash
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
  end

end