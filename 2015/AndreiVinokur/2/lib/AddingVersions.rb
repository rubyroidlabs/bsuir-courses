require 'json'

class AddingVersions
  GEMS_URL = 'https://rubygems.org/api/v1/versions/'
  def initialize(name)
    @name = name
  end

  def add
    json = `curl #{GEMS_URL}#{@name}.json`
    result = []
    begin
      JSON.parse(json).each { |entry| result << entry.fetch('number') }
    rescue JSON::ParserError
      puts json
    end
    result
  end
end