class Version
  def initialize(versions, gem_version, parameter)
    @versions = versions
    @gem_version = gem_version
    @parameter = parameter
    @find_versions = (0..versions.size() - 1).to_a
  end

  def greater_equally(p)
    index = 0
      @versions.each do |version|
        if (version[0, @gem_version[@parameter.index(p)].size] == @gem_version[@parameter.index(p)])
          index = @versions.index(version)
        end
      end
      @find_versions -= @find_versions - (0..index).to_a
  end

  def less_equally(p)
    index = 0
    @versions.each do |version|
      if (version[0, @gem_version[@parameter.index(p)].size] == @gem_version[@parameter.index(p)])
        index = @versions.index(version)
        break
      end
    end
    @find_versions -= @find_versions - (index..(@versions.size - 1)).to_a
  end

  def greater(p)
    index = 0
    @versions.each do |version|
      if (version[0, @gem_version[@parameter.index(p)].size] == @gem_version[@parameter.index(p)])
        index = @versions.index(version)
        break
      end
    end
    @find_versions -= @find_versions - (0..index - 1).to_a
  end
  
  def less(p)
    index = 0
    @versions.each do |version|
      if(version[0, @gem_version[@parameter.index(p)].size] == @gem_version[@parameter.index(p)])
        index = @versions.index(version)
        end
    end
    @find_versions -= @find_versions - (index + 1..(@versions.size - 1)).to_a
  end

  def greater_tilde(p)
    index = 0
    @versions.each do |version|
      if (version[0, @gem_version[@parameter.index(p)].size] == @gem_version[@parameter.index(p)])
        index = @versions.index(version)
      end
    end

    index_to = index
    while @versions[index].split('.')[1].to_i == @versions[index_to].split('.')[1].to_i do
      break if (index_to == 0)
      index_to -= 1
    end
    @find_versions -= @find_versions - (index_to + 1..index).to_a
  end

  def find()
    @parameter.each do |p|
      case p
      when '>=' then
        greater_equally(p)
      when '<=' then
        less_equally(p)
      when '>' then
        greater(p)
      when '<' then
        less(p)
      when '~>' then
        greater_tilde(p)
      end

      if (@find_versions.empty?)
        puts 'Version not found!'
        exit
      end
    end
  end

  def getFindVersions()
    @find_versions
  end
end
