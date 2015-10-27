class GemVersion
  def initialize(versions, gem_version)
    @vers = versions
    @gem_version = gem_version
  end

  def filter
    @vers.map { |v| v if Gem::Dependency.new('', @gem_version).match?('', v) }
  end
end
