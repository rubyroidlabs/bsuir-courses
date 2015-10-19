# throws JSON::ParserError => e
# throws ArgumentError => e
require 'colorize'
require 'net/http'
require 'uri'
require 'json'

class GemVersionsGetter
  def get_versions(name)
    @json = get_versions_json (name)
    get_versions_array(@json)
  end

  private

  def get_versions_json(name)
    raise ArgumentError if name.nil?
    uri = URI("https://rubygems.org/api/v1/versions/#{name}.json")
    result = Net::HTTP.get (uri)
    JSON.parse(result)
  rescue JSON::ParserError
    raise JSON::ParserError, result
  rescue ArgumentError
    raise ArgumentError, 'Gem name is empty'
  end

  def get_versions_array(json)
    json.map { |e| e['number'] } .uniq
  end
end
