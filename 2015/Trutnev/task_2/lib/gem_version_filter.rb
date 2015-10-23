class VersionFilter
  attr_reader :versions

  def initialize(versions)
    @versions = versions.map { |version| Gem::Version.new(version) }
  end

  def filter(condition)
    result = []
    operator, needed_version = condition.split

    needed_version = Gem::Version.new(needed_version)

    case operator
    when '~>'
      result = versions.select do |version|
        version >= needed_version && version < needed_version.bump
      end
    else
      result = versions.select do |version|
        version.send(operator, needed_version)
      end
    end

    result.map { |version| version.to_s }
  end
end
