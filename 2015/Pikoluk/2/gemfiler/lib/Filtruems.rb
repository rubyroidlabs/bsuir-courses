class Filtruems
  def initialize(versions, gem_version)
    @versions = versions
    @gem_version = gem_version
  end

  def filter
    @versions.map do |v|
        v if Gem::Dependency.new('', @gem_version).match?('', v)
      end
    rescue Gem::Requirement::BadRequirementError
      puts 'Retard :) AZAZAZA'
  end
end
