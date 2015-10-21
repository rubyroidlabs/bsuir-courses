class ColoredOutput
  def initialize(all_versions, filtered_versions)
    @all_versions = all_versions
    @filtered_versions = filtered_versions
  end

  def output
    @all_versions.each { |v| puts (@filtered_versions.include?(v) ? v.red : v) }
  end
end
