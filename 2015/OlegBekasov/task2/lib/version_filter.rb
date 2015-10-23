module VersionFilter
  def filter(version, option1, option2)
    begin
      requirement = Gem::Requirement.new(option1, option2)
    rescue Gem::Requirement::BadRequirementError
      puts 'Check required version'.red
    end
    requirement.satisfied_by?(Gem::Version.new(version))
  end
end
