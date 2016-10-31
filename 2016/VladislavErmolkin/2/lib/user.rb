require 'json'

class User
  attr_accessor :id, :sem, :subjects

  def initialize(id)
  	@id = id
  	path = "./users/user_#{@id}.txt"
    file = File.open(path, 'a+')
    if File.zero?(path)
    	fill_attrs({})
    else
    	fill_attrs JSON.parse(file.read)
    end
    file.close
  end

  def fill_attrs(params)
  	puts params.inspect
  	fill_sem_attrs params
    @subjects = params.fetch('subjects', nil)
  end

  def fill_sem_attrs(params)
	@sem = params.fetch('sem', Hash.new)
	if @sem.empty?
	  	@sem["start"] = nil
	    @sem["end"] = nil
	    @sem["is_now?"] = false
	    @sem["phase"] = 0
	end
  end

  def save
    puts 'IN SAVE_USER.'
    path = "./users/user_#{@id}.txt"
    file = File.open(path, 'w')
    file.print JSON.generate itself.to_hash
    file.close
  end

  def to_hash
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
  end

end


# user = User.new ({:sem_start => '1.1.1', :sem_end => '1.1.2', :subjects => ['math', 'english']})

# p user.sem_start, user.sem_end, user.subjects

