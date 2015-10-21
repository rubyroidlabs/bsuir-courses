class Searcher
  attr_reader :gem_name
  attr_accessor :versions

  def initialize(name)
    @name = name
    @versions = []
  end

  def search
    version_list = Gems.versions(@name)
    @versions = version_list.map { |details| details['number'] }
    rescue
      raise 'Cannot found gem'
  end
end

class Filter
  attr_reader :version_spec
  attr_reader :versions

  def initialize(version_specs, versions)
    @version_specs = version_specs
    @versions = versions.clone
  end

  def version_matches?(version)
    @version_specs.all? do |spec|
      Gem::Dependency.new('', spec).match?('', version)
    end
  rescue
    raise 'Wrong spec'
  end

  def match
    @versions.each do |version|
      yield version, version_matches?(version)
    end
  end
end
