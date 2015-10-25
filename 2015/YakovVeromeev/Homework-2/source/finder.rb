require 'json'

class Finder
  def self.search(name)
    versions = []
    json = `curl https://rubygems.org/api/v1/versions/#{name}.json`
    JSON::parse(json).each { |current| versions << current.fetch('number') }
    versions.reverse
    end
end
