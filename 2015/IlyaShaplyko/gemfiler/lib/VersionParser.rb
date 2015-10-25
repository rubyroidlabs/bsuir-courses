require 'gems'
class VersionParser
  attr_reader :gem_name

  def initialize(gem_name)
    @gem_name = gem_name
  end

  def fetch
    versions = Gems.versions gem_name
    versions.map { |s| s['number'] }
    rescue
      raise 'Input correct gem name'
  end
end
