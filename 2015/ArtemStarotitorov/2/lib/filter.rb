class Filter
  def get_hash_of_filtered_versions(versions, conditions)
    hash_of_versions = {}
    begin
      requirement = Gem::Requirement.new(conditions)
      versions.each do |v|
        hash_of_versions[v] = requirement.satisfied_by?(Gem::Version.new(v))
      end
    rescue Gem::Requirement::BadRequirementError
      puts 'Check version of gem.'
      exit
    end
    hash_of_versions
  end
end
