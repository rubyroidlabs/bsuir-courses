class VersionMatcher
  def self.match_versions(versions, conditions)
    versions_hash = {}
    requirement =  Gem::Requirement.new(conditions)
    versions.each do |v|
      versions_hash[v] = requirement.satisfied_by? Gem::Version.create(v)
    end
    versions_hash
  end
end
