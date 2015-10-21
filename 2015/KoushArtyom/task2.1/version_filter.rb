class VersionFilter
  def initialize(versions)
    @versions = versions
  end

  def filter(gem_version1, gem_version2)
    kek = []
    lel = []
    begin # Smells like govnokod
      @versions.each do |v|
        kek << v if Gem::Dependency.new('', gem_version1).match?('', v)
      end

      if !gem_version2.nil?
        @versions.each do |v|
          lel << v if Gem::Dependency.new('', gem_version2).match?('', v)
        end
        kek & lel
      else
        kek
      end
    rescue Gem::Requirement::BadRequirementError
      puts 'Error. Check version of the gem'
    end
  end
end
