class Filter
	def self.is_satisfied?(version, conditions)
		satisfied = []

    conditions.each do |condition|
      begin
        needed_version = Gem::Requirement.new(condition)
        if needed_version.satisfied_by?(Gem::Version.new(version))
          satisfied << true
        else
          satisfied << false
        end
      rescue StandardError
        puts "Incorrect arguments"
        exit
      end
    end

		satisfied.each do |good_cond|
      if good_cond == false
        return false
      end
    end
    
    true
	end
end
