require 'gems'

class Searcher
  def self.get_versions(gem_name)
    begin
      gem_versions = Gems.search(gem_name).map { |g| g['version'] }.to_a
      fail "Gem doesn't exists." if gem_versions.empty?
    rescue StandartError => error
      puts error.message
      exit
    end
    gem_versions
  end
end