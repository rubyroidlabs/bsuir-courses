class VersionFetcher
  def initialize(name)
    @name = name
  end

  def fetch
    json = `curl https://rubygems.org/api/v1/versions/#{@name}.json`
    result = []
    begin
      result = JSON.parse(json)
      result.map &:["number"]
      end
      puts result
    rescue JSON::ParserError
      puts 'Error. Check the way of writing gem name'.red
    end
    result
  end
end
