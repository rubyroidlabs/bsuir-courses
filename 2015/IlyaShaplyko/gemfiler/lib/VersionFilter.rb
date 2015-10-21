class VersionFilter

  def initialize(all_versions, gem_version)
    @all_versions = all_versions
    @gem_version = gem_version
  end

  def filter
    begin
      @all_versions.map {|v| v if Gem::Dependency.new('comparison', @gem_version).match?('comparison', v)}
    rescue Gem::Requirement::BadRequirementError
      puts "Error in writing gem version".green
    end
  end
end
