class Filter
  def initialize(versions, version_from, version_to)
    @versions = versions
    @version_from = version_from
    @version_to = version_to
  end

  def filter
    m = lambda { |version, v| Gem::Dependency.new('', version).match?('', v) }
    @versions.map { |v| v if m.call(@version_from, v) && m.call(@version_to, v) }
  end
end
