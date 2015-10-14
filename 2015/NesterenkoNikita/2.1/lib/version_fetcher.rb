require 'json'

class VersionFetcher

  def initialize(name)
    @name = name
  end

  def fetch
    result = `curl https://rubygems.org/api/v1/versions/#{@name}.json`
    if result == nil
      raise NameError
    end
    json = JSON.parse(result)
    json.map { |s| s["number"] }
  end

end