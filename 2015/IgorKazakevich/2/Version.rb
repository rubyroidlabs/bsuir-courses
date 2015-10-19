class Version
  def initialize(versions, gemVersion, parameter)
    @versions = versions
    @gemVersion = gemVersion
    @parameter = parameter
    @findVersions = (0..versions.size() - 1).to_a
  end  


  def greaterEqually(p)
    index = 0
      @versions.each do |version|
        if(version[0, @gemVersion[@parameter.index(p)].size] == @gemVersion[@parameter.index(p)])
          index = @versions.index(version)
        end
      end
      @findVersions -= @findVersions - (0..index).to_a
    return @findVersions
  end

  def lessEqually(p)
    index = 0
    @versions.each do |version|
      if(version[0, @gemVersion[@parameter.index(p)].size] == @gemVersion[@parameter.index(p)])
        index = @versions.index(version)
        break
      end
    end
    @findVersions -= @findVersions - (index..(@versions.size - 1)).to_a
    return @findVersions
  end

  def greater(p)
    index = 0
    @versions.each do |version|
      if(version[0, @gemVersion[@parameter.index(p)].size] == @gemVersion[@parameter.index(p)])
        index = @versions.index(version)
        break
      end
    end
    @findVersions -= @findVersions - (0..index - 1).to_a    
    return @findVersions
  end
  
  def less(p)
    index = 0
    @versions.each do |version|
      if(version[0, @gemVersion[@parameter.index(p)].size] == @gemVersion[@parameter.index(p)])
        index = @versions.index(version)
        end
    end
    @findVersions -= @findVersions - (index + 1..(@versions.size - 1)).to_a
    return @findVersions
  end

  def greaterTilde(p)
    index = 0
    @versions.each do |version|
      if(version[0, @gemVersion[@parameter.index(p)].size] == @gemVersion[@parameter.index(p)])
        index = @versions.index(version)
      end
    end

    indexTo = index 
    while @versions[index].split('.')[1].to_i == @versions[indexTo].split('.')[1].to_i do
      break if(indexTo == 0)
      indexTo -= 1
    end
    @findVersions -= @findVersions - (indexTo + 1..index).to_a
  end   

  def find()
    @parameter.each do |p|
      case p
      when '>=' then
        greaterEqually(p)
      when '<=' then
        lessEqually(p)
      when '>' then
        greater(p)
      when '<' then
        less(p)
      when '~>' then
        greaterTilde(p)
      end

      if(@findVersions.empty?)
        puts "Version not found!"
        exit
      end
    end
  end

  def getFindVersions()
    return @findVersions
  end
end
