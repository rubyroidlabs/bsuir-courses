class VersionFilter
  def initialize(all_vers, gem_version)
    @all_vers = all_vers
    @gem_version = gem_version
  end

  def filter
    begin
      @all_vers.map do |v|
        v if Gem::Dependency.new('', @gem_version).match?('', v)
      end
    rescue Gem::Requirement::BadRequirementError
      puts 'Error in writing gem version'.green
    end
  end
end
