require 'set'

class Filter
  def self.filter_versions(require_versions, available_versions)
    result_versions = Set.new
    begin
      requirement = Gem::Requirement.new(require_versions)
      available_versions.each do |variable|
        if requirement.satisfied_by?(Gem::Version.new(variable.text))
          result_versions.add(variable.text)
        end
      end
    rescue ArgumentError => exp
      puts 'Your parameters are wrong!'
      exit
    end
    result_versions
  end
end
#Newline
