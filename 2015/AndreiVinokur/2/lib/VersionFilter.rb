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
    when '!='
      result -= needed_version
    when '>'
      @versions.select do |version|
        result << version if version > needed_version
      end
    when '<'
      @versions.select do |version|
        result << version if version < needed_version
      end
    when '>='
      @versions.select do |version|
        result << version if version >= needed_version
      end
    when '<='
      @versions.select do |version|
        result << version if version <= needed_version
      end
    when '~>'
      result = @versions.select do |version|
        if (version >= needed_version) && (version < needed_version.bump)
          result << version
        end
      end
    else
      puts 'Incorrect comparison operator'
      puts 'Template of comparison operator: =; !=; >; <; >=; <=; ~>;'
      exit
    end
    result
  end
end
