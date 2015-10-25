class VersionFilter
  def initialize (versions)
    @versions = versions.map { |version| Gem::Version.new(version) }
  end

  def filter (specifier)
    operator, needed_version = specifier.split
    needed_version = Gem::Version.new(needed_version)
    result = []
    result = @versions.select do |version|
      case operator
      when '~>'
        if version >= needed_version && version < needed_version.bump
          result = result.map  &:to_s.(version)
        end
      else
        if  version.send(operator.to_sym, needed_version)
          result = result.map  &:to_s.(version)
        end
      end
    end
    result
  end
end
