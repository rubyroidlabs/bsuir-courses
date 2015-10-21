require 'json'

class VersionFilter
  def initialize(versions)
    @versions = versions.map { |version| Gem::Version.new(version) }
  end

  def filter(interval)
    operator, needed_version = interval.split
    needed_version = Gem::Version.new(needed_version)
    results = []
    case operator
    when '='
      result = needed_version
    when '!='
      result -= needed_version
    when '>'
      results = @versions.select do |version|
        needed_version < version
      end
      results = results.map &:to_s
    when '<'
      results = @versions.select do |version|
        needed_version > version
      end
      results = results.map &:to_s
    when '>='
      results = @versions.select do |version|
        needed_version <= version
      end
      results = results.map &:to_s
    when '<='
      results = @versions.select do |version|
        needed_version >= version
      end
      results = results.map &:to_s
    when '~>'
      results = @versions.select do |version|
        needed_version <= version && version < needed_version.bump
      end
      results = results.map &:to_s
    else
      puts 'Incorrect comparison operator'
      puts 'Template of comparison operator: =; !=; >; <; >=; <=; ~>;'
      exit
    end
    results
  end
end
