class VersionFilter

  def initialize(versions)
    @versions = versions.map { |version| Gem::Version.new(version) }
  end

  def filter(specifier)
    operator, needed_version = specifier.split
    needed_version = Gem::Version.new(needed_version)
    result = []
    case operator
    when '~>'
      result = @versions.select do |version|
        version >= needed_version && version < needed_version.bump
      end
      result = result.map { |version| version.to_s }
    else
      result = @versions.select do |version|
        version.send(operator.to_sym, needed_version)
      end
      result = result.map { |version| version.to_s }
    end
    result
  end
end
