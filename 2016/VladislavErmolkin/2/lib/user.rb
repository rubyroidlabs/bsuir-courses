require 'json'

class User
  attr_accessor :id, :sem, :subjects

  def initialize(id)
    @id = id
    path = "./users/user_#{@id}.txt"
    file = File.open(path, 'a+')
    File.zero?(path) ? fill_attrs({}) : fill_attrs(JSON.parse(file.read))
    file.close
  end

  def fill_attrs(params)
    fill_sem_attrs params
    fill_subject_attrs params
  end

  def fill_sem_attrs(params)
    @sem = params.fetch('sem', Hash.new)
    if @sem.empty?
      @sem["start"] = nil
      @sem["end"] = nil
      reset_sem_system_variables
    end
  end

  def fill_subject_attrs(params)
    @subjects = params.fetch('subjects', Hash.new)
    if @subjects.empty? then reset_subject_system_variables end
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

  def get_subject_items
    @subjects.select { |key, value| key[0...2] != "__"}
  end

  def save
    path = "./users/user_#{@id}.txt"
    file = File.open(path, 'w')
    file.print JSON.generate itself.to_hash
    file.close
  end

  def reset
    fill_sem_attrs({})
    fill_subject_attrs({})
  end

  def to_hash
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
  end

end
