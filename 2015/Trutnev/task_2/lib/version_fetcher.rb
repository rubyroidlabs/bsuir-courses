require 'json'
require 'rest_client'

class VersionFetcher
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def fetch
    raw = RestClient.get "https://rubygems.org/api/v1/versions/#{name}.json"

    response = JSON.parse(raw)

    versions = response.map { |v| v['number'] }
  end
end


