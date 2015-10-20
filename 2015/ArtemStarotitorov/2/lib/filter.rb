class Filter
  def self.get_hash_of_filtered_versions(versions, conditions)
    begin
      hash_of_versions = {}
      requirement = Gem::Requirement.new(conditions)
      versions.each do |v|
        hash_of_versions[v] = requirement.satisfied_by?(Gem::Version.new(v))
      end
    rescue StandardError => exc
      puts exc.message
      exit
    end
    hash_of_versions
  end
end
