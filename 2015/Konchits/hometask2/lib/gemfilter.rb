require 'colorize'

class VersionFilter
  def initialize(versions)
    @versions = versions
  end

  def filter(gem_version1, gem_version2)
    begin
      version1, version2 = [], []
      @versions.each do |v| version1 << v 
        if Gem::Dependency.new('', gem_version1).match?('', v)
      end
      if gem_version2.nil?
        version1
      else
        @versions.each do |v| version2 << v 
        if Gem::Dependency.new('', gem_version2).match?('', v)
        version1 & version2
      end
      end
    rescue Gem::Requirement::BadRequirementError
      puts 'Check input versions of the gem!'.red
    end
  end
end
