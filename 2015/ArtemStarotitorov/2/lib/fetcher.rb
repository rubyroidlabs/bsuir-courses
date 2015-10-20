require 'json'
require 'net/http'

class Fetcher
  def self.get_array_of_versions(required_gem)
    begin
      uri = URI("https://rubygems.org/api/v1/versions/#{required_gem}.json")
      response = Net::HTTP.get_response(uri)
      hashes = JSON.parse(response.body)
      items = []
      hashes.each { |h| items << h['number'] }
    rescue StandardError => exc
      puts exc.message
      exit
    end
    items
  end
end
