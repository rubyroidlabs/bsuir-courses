require 'json'

class VersionParser
  def initialize(gem_name)
    @gem_name = gem_name
  end

  def parse
    url = `curl https://rubygems.org/api/v1/versions/#{@gem_name}.json`
    begin
      json = JSON.parse(url)
      results = []
      json.each do |j|
        results << j['number']
      end
      results
    rescue JSON::ParserError
      puts 'Error. Wrong name of the gem or some trouble accured
            with your network connection'
    end
  end
end
