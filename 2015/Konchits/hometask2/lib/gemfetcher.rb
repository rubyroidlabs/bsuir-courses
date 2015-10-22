require 'json'

class VersionFetcher
  def initialize(gem_name)
    @gem_name = gem_name
  end

  def fetch
    versions = `curl https://rubygems.org/api/v1/versions/#{@gem_name}.json`
    begin
      json = JSON.parse(versions).map { |ver| ver['number'] }
    rescue JSON::ParserError
      puts 'Check your internet connection!'.red
    end
  end
end
