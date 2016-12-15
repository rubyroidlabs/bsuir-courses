require 'json'

class VersionFetcher

  def initialize(name)
    @name = name
  end

  def fetch
    result = `curl https://rubygems.org/api/v1/versions/#{@name}.json`
    begin
      json = JSON.parse(result)
      return json.map { |s| s["number"] }
    rescue JSON::ParserError => e
      raise Exception, "Check the gem name!"
    end
  end

end
