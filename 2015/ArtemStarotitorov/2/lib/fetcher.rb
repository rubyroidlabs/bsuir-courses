require 'json'
require 'net/http'

class Fetcher
  def get_array_of_versions(required_gem)
    begin
      uri = URI("https://rubygems.org/api/v1/versions/#{required_gem}.json")
      response = Net::HTTP.get_response(uri)
      hashes = JSON.parse(response.body)
      items = []
      hashes.each { |h| items << h['number'] }
    rescue JSON::ParserError
      puts 'Wrong name of the gem or some troubles with network connection.'
      exit
    end
    items
  end
end
