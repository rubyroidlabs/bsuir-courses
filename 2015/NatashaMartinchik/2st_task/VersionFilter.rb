class VersionFilter
  def initialize(result)
    @version = result.map { |version| Gem::Version.new(version) }
  end

  def filter(specifier, operator)
    version_hash = {}
    requirement = Gem::Requirement.new(operator)
    specifier.each do |v|
      version_hash[v] = requirement.satisfield_by Gem::Version.create(v)
    end
    version_hash
  end
end
