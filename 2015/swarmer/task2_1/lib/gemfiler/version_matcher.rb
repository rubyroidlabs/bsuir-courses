class Gemfiler::VersionMatcher
  attr_reader :version_spec
  attr_reader :versions

  def initialize(version_specs, versions)
    @version_specs = version_specs
    @versions = versions.clone
  end

  def version_matches?(version)
    @version_specs.all? do |spec|
      Gem::Dependency.new('', spec).match?('', version)
    end
  rescue Gem::Requirement::BadRequirementError
    raise Gemfiler::MatchError.new("Invalid version spec!")
  end

  def each_with_flag
    @versions.each do |version|
      yield version, version_matches?(version)
    end
  end
end
