require './filter.rb'

class VersionChecker
	def self.check_versions(versions, conditions)
		versions_hash = Hash.new

    versions.each do |v|
      versions_hash[v] = Filter.is_satisfied?(v, conditions)
    end
    
    versions_hash
  end
end
