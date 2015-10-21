#Fetcher
require 'net/http'
require 'uri'
require 'json'
class Gem_fetcher
  def self.fetch(gem_name)
    find_versions = []
    url = "https://rubygems.org/api/v1/versions/#{gem_name}.json"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    #puts response.body if response.is_a?(Net::HTTPSuccess)
    if response.code == '200' && response.message == 'OK'
      json = JSON.parse(response.body)
      if json.empty?
        fail NameError.new "Gem #{gem_name} not found. Check <gem name> and try again."
      else
        find_versions = json.map { |s| s["number"] }
      end
    else
      fail NameError.new "Gem #{gem_name} not found. Check <gem name> and try again."
    end
    #puts find_versions
    return find_versions
  end
end
