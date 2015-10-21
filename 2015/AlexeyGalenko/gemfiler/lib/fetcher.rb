require 'json'
require 'rest-client'

class Fetcher
  attr_reader :gem_name

  def initialize(gem_name)
    @gem_name = gem_name
  end

  def fetch
    RestClient.get("https://rubygems.org/api/v1/versions/#{gem_name}.json")
  rescue RestClient::ExceptionWithResponse => err
    puts err.response
  end

  def parse(long_string)
    versions = JSON.parse(long_string)
    versions.map { |s| s['number'] }
  rescue JSON::ParserError
    puts 'JSON parser error'
  end
end
