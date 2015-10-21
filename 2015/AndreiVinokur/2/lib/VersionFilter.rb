class VersionFilter
  def initialize(versions)
    @versions = versions.map { |version| Gem::Version.new(version) }
  end

  def filter(interval)
    operator, needed_version = interval.split
    needed_version = Gem::Version.new(needed_version)
    result = []
    case operator
      when '='
        result = needed_version
        puts 1
      when '!='
        result -= needed_version
        puts 2
      when '>'
        result = @versions.select do |version|
        needed_version if version > needed_version
        puts 3 
      end
      when '<'
        result = @versions.select do |version|
        needed_version if version < needed_version
        puts 4
      end
      when '>='
        result = @versions.select do |version|
        needed_version if version >= needed_version
      end
      when '<='
        @versions.select do |version|
        result << version if version <= needed_version
      end
      when '~>'
        result = @versions.select do |version|
        needed_version if (version >= needed_version) && (version < needed_version.bump)
      end
      else
        puts 'Incorrect comparison operator'
        puts 'Template of comparison operator: =; !=; >; <; >=; <=; ~>;'
        exit
      end
      result
    end
  end
