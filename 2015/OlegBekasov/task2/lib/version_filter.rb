module VersionFilter
  def filter(version, option1, option2)
    Gem::Requirement.new(option1, option2).satisfied_by?(Gem::Version.new(version))
  end
end