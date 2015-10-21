class Filter

  def initialize(versions, version_from, version_to)
    @versions = versions
    @version_from = version_from
    @version_to = version_to
  end
  
  def filter
    match_ = lambda {|version, v| Gem::Dependency.new('', version).match?('', v)}
    @versions.map {|v| v if match_.call(@version_from, v) && match_.call(@version_to, v)}
  end
end
