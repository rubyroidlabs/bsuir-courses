module VersionFilter
  def filter(version, option1, option2)
  	begin
      Gem::Requirement.new(option1, option2).
        satisfied_by?(Gem::Version.new(version))
    rescue Gem::Requirement::BadRequirementError
    end
  end
end
