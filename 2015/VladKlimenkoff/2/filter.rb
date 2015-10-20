class Filter
	def self.is_satisfied?(version, condition)
		satisfied = false
		needed_version = Gem::Requirement.new(condition)
		if needed_version.satisfied_by?(Gem::Version.new(version))
			satisfied = true
		end
		satisfied
	end
end