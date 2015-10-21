class ColoredOutput
  def initialize(all_versions, filtered_versions)
    @all_versions = all_versions
    @filtered_versions = filtered_versions
  end

  def output
    @all_versions.each { |vers| puts (@filtered_versions.include?(vers) ? vers.red : vers) }
  end
end
