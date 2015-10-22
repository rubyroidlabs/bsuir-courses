class VersionFilter
  def initialize(result)
    @version = result.map { |version| Gem::Version.new(version) }
  end

  def filter(specifier, operator)
    needed_version = Gem::Version.new(specifier)
    results = []

    case operator
    when '~>'
      results = @version.select do |version|
        needed_version <= version && version < needed_version.bump
      end
      results = results.map &:to_s
    when '<'
      results = @version.select do |version|
        needed_version > version
      end
      results = results.map &:to_s
    when '>'
      results = @version.select do |version|
        needed_version < version
      end
      results = results.map &:to_s
    end
    results
  end
end