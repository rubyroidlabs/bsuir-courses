require 'gems'

# Fetch all possible versions of gem.
class Fetcher
  def self.get_versions(gem_name)
    begin
      gem_versions = Gems.search(gem_name).map { |g| g['version'] }.to_a
      fail "This gem doesn't exists." if gem_versions.empty?
    rescue StandartError => e
      puts e.message
      exit
    end
    gem_versions
  end
end
