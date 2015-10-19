class VersionFilter
  def initialize (versions)
    @versions = versions.map { |version| Gem::Version.new(version) }
  end

  def filter (specifier) # method that find right gem_versions 
    operator, needed_version = specifier.split
    needed_version = Gem::Version.new(needed_version)
    result = [] # array of gem_versions
    case operator # choose versions depending on the input 
    when '~>'
      result = @versions.select do |version|
        version >= needed_version && version < needed_version.bump
      end
      result = result.map { |version| version.to_s }
    else
      result = @versions.select do |version|
        version.send(operator.to_sym, needed_version)
      end
      result = result.map  &:to_s.(version)
    end
    result # return result: gem_versions  
  end
end
