class Filter
  def self.satisfied?(version, conditions)
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
        puts 'Incorrect arguments'
        exit
      end
    end

    if satisfied.all? { |s| s }
      true
    else
      false
    end
  end
end
