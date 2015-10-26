require 'json'

class Finder
  def self.search(name)
    versions = []
    # a json request returns array of datd hashes for gem versions
    json = `curl https://rubygems.org/api/v1/versions/#{name}.json`
    # but we are interested only in numbers of them
    JSON::parse(json).each { |current| versions << current.fetch('number') }
    # if gem name is wrong we do not get any hashes
    #and array of versions will be empty
    raise Wrong_Gem_name if versions.empty?
    # reverse is needed because
    # latest versions are placed at the top of array
    # and it-s not very beautiful to watch
    versions.reverse
  end
end
