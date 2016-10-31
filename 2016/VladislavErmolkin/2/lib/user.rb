class User
  attr_accessor :sem_phase, :sem_start, :sem_end, :subjects

  def initialize(params)
    @sem_start = params.fetch("sem_start", nil)
    @sem_end = params.fetch("sem_end", nil)
    @sem_phase = params.fetch("sem_phase", 0)
    @subjects = params.fetch("subjects", nil)
  end

  def to_hash
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
  end

end


# user = User.new ({:sem_start => '1.1.1', :sem_end => '1.1.2', :subjects => ['math', 'english']})

# p user.sem_start, user.sem_end, user.subjects

