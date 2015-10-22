require 'open-uri'
require 'json'

class Fetcher
  def initialize(name)
    @name = name
  end

  def fetch
    ver = open("https://rubygems.org/api/v1/versions/#{@name}.json").read
    result = []
    begin
      JSON.parse(ver).each do |entry|
        result.push(entry['number'])
      end
    rescue JSON::ParserError
    end
    result
  end
end
