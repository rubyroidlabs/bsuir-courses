class Gemfiler::VersionFetcher
  attr_reader :gem_name
  attr_accessor :versions

  def initialize(gem_name)
    @gem_name = gem_name
    @versions = []
  end

  def fetch_from_rubygems
    begin
      version_details = Gems.versions(@gem_name)
      if !version_details.instance_of?(Array)
        raise Gemfiler::FetchError.new("Gem not found!")
      end
    rescue SocketError
      raise Gemfiler::FetchError.new("Cannot download gem information")
    end

    @versions = version_details.map { |details| details['number'] }
  end
end
