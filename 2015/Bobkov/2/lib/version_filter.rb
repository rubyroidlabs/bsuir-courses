class Filter
  def initialize(versions)
    @versions = versions.map { |version| Gem::Version.new(version) }
  end

  def filter(specifier)
    operator, needed_version = specifier.split
    needed_version = Gem::Version.new(needed_version)
    result = []
    case operator
    when '>'
      result = @versions.select do |version|
        version > needed_version
      end
    when '>='
      result = @versions.select do |version|
        version >= needed_version
      end
    when '<'
      result = @versions.select do |version|
        version < needed_version
      end
    when '<='
      result = @versions.select do |version|
        version <= needed_version
      end
    when '~>'
      result = @versions.select do |version|
        version >= needed_version &&
        version < needed_version.bump
      end
    end
    result = result.map(&:to_s)
    result
  end

  def filter2(specifier, specifier2)
    operator, needed_version = specifier.split
    operator2, needed_version2 = specifier2.split
    needed_version = Gem::Version.new(needed_version)
    needed_version2 = Gem::Version.new(needed_version2)
    result = []
    case operator && operator2
    when '>' && '<'
      result = @versions.select do |version|
        version > needed_version &&
        version < needed_version2
      end
    when '~>' && '<'
      result = @versions.select do |version|
        version >= needed_version &&
        version < needed_version.bump &&
        version < needed_version2
      end
    when '>=' && '<'
      result = @versions.select do |version|
        version >= needed_version &&
        version <= needed_version2
      end
    when '>' && '<='
      result = @versions.select do |version|
        version > needed_version &&
        version <= needed_version2
      end
    when '~>' && '<='
      result = @versions.select do |version|
        version >= needed_version &&
        version < needed_version.bump &&
        version <= needed_version2
      end
    when '>=' && '<='
      result = @versions.select do |version|
        version >= needed_version &&
        version <= needed_version2
      end
    end
    result = result.map(&:to_s)
    result
  end
end
