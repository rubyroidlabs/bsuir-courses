class Filter
  def initialize(versions, version_from, version_to)
    @versions = versions
    @ver_from = version_from
    @ver_to = version_to
  end

  def filter
    m = lambda { |version, v| Gem::Dependency.new('', version).match?('', v) }
    @versions.map { |v| v if m.call(@ver_from, v) && m.call(@ver_to, v) }
  end
end
