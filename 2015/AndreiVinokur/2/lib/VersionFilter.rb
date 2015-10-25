require 'json'

class VersionFilter
  def initialize(versions)
    @versions = versions.map { |version| Gem::Version.new(version) }
  end

  def get_version(interval)
    operator, needed_version = interval.split
    needed_version = Gem::Version.new(needed_version)
    result = []
    case operator
    when '~>'
      result = @versions.select do |version|
        version >= needed_version && version < needed_version.bump
      end
      result.map { |version| version.to_s }
    else
      result = @versions.select do |version|
        version.send(operator.to_sym, needed_version)
      end
      result.map { |version| version.to_s }
    end
  end

  def filter(interval1, interval2)
    results = []
    needed_version1 = VersionFilter.new(@versions).get_version(interval1)
    if interval2 != nil
      needed_version2 = VersionFilter.new(@versions).get_version(interval2)
      results = needed_version1 & needed_version2
    else
      results = needed_version1
    end
  end
end
