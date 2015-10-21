require 'json'

class VersionFetcher
  def initialize(name)
    @name = name
  end

  def fetch
    json = `curl https://rubygems.org/api/v1/versions/#{@name}.json`
    result = []
    begin
      JSON.parse(json).each do |entry|
        result << entry.fetch('number')
      end
    rescue JSON::ParserError
      puts json
    end
    result
  end
end
