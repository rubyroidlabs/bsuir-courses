class GemVersion
  def initialize(versions, gem_version)
    @versions = versions
    @gem_version = gem_version
  end

  def filter
    @versions.map { |v| v if Gem::Dependency.new('', @gem_version).match?('', v) }
  end
end