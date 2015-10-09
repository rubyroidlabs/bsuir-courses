require 'json'
require 'net/http'

class VersionFetcher
  def self.get_version_array(gemname)
    begin
      response = Net::HTTP.get_response('rubygems.org', '/api/v1/versions/' + gemname + '.json')
      items = JSON.parse(response.body).map { |s| s['number'] }
    rescue StandardError => exc
      puts exc.message
      exit
    end
    items
  end
end
