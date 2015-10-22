# Class for recieving array of gem versions
class Fetcher
  def initialize(gem_name)
    @gem_name = gem_name
  end

  def find_versions
    begin
      @gem_versions = Gems.search(@gem_name).map { |str| str['version'] }.to_a
      fail 'Invalid gem name! Try again.' if gem_versions.empty?
    rescue SocketError
      raise StandartError 'Connection problems, try later'
    end
    @gem_versions
  end

  attr_reader :gem_versions
end
