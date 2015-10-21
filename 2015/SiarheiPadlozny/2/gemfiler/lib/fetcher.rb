require 'gems'

# Fetch all possible versions of gem.
class Fetcher
  attr_reader :gem_versions

  def initialize(name)
    @gem_name = name
  end

  def versions
    @gem_versions = Gems.search(@gem_name).map { |g| g['version'] }.to_a
    fail "This gem doesn't exists." if gem_versions.empty?
  rescue SocketError
    raise StandartError 'No Internet!'
  end
end
