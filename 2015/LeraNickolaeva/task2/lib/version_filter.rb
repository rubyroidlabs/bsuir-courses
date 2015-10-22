class VersionFilter
  def initialize(versions)
    @versions = versions.map { |version| Gem::Version.new(version) }
  end

  def res_map
    result = result.map  &:to_s.(version)
  end

  def filter(specifier)
    operator, needed_version = specifier.split
    needed_version = Gem::Version.new(needed_version)
    result = []
    result = @versions.select do |version|
      case operator
        when '~>'
          version >= needed_version && version < needed_version.bump 
          res_map
          else
            version.send(operator.to_sym, needed_version) 
            res_map 
      end
      result 
    end
  end
end
