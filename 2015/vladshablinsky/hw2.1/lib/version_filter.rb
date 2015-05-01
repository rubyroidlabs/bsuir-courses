class VersionFilter

  def self.matches?(version, specs)
    requirement = Gem::Requirement.new(specs)
    requirement.satisfied_by? Gem::Version.new(version)
  end

end
