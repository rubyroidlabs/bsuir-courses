class VersionFilter
  def initialize(all_versions, gem_version)
    @all_versions = all_versions
    @gem_version = gem_version
  end

  def filter
    begin
      @all_versions.map  do |v|
        v if Gem::Dependency.new('', @gem_version).match?('', v)
      end
    rescue Gem::Requirement::BadRequirementError
      puts 'Error in writing gem version'.green
    end
  end
end
