require 'json'
require 'redis'

# Class User.
class User
  attr_accessor :id, :sem, :subjects, :submit
  @@redis = Redis.new(host: '127.0.0.1', port: 6379, db: 15)

  def initialize(id)
    @id = id
    user_hash = if @@redis.exists "user_#{id}"
                  JSON.parse(@@redis.get("user_#{id}"))
                else
                  {}
                end
    attrs user_hash
  end

  def attrs(params)
    sem_attrs params
    subject_attrs params
    submit_attrs params
  end

  def submit_attrs(params)
    @submit = params.fetch('submit', {})
    reset_submit_system_variables if @submit.empty?
  end

  def sem_attrs(params)
    @sem = params.fetch('sem', {})
    return unless @sem.empty?
    @sem['start'] = nil
    @sem['end'] = nil
    reset_sem_system_variables
  end

  def subject_attrs(params)
    @subjects = params.fetch('subjects', {})
    reset_subject_system_variables if @subjects.empty?
  end

  def reset_sem_system_variables
    @sem['__is_now?'] = false
    @sem['__phase'] = 0
  end

  def reset_subject_system_variables
    @subjects['__is_now?'] = false
    @subjects['__phase'] = 0
    @subjects['__current'] = nil
  end

  def reset_submit_system_variables
    @submit['__is_now?'] = false
    @submit['__phase'] = 0
    @submit['__current'] = nil
  end

  def compact_subjects
    @subjects.select! { |_, value| !value.is_a?(Array) || !value.empty? }
  end

  def subject_items
    @subjects.select { |key, _| key[0...2] != '__' }
  end

  def save
    @@redis.set "user_#{@id}", JSON.generate(itself.to_hash)
    puts @@redis.get "user_#{@id}"
  end

  def reset
    set_sem_attrs({})
    set_subject_attrs({})
    set_submit_attrs({})
  end

  def to_hash
    hash = {}
    instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end
end
