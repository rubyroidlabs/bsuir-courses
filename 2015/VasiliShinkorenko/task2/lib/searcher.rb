require 'json'

class Searcher
  def initialize(gem_name)
    @gem_name = gem_name
  end

  def search
    result = `curl https://rubygems.org/api/v1/versions/#{@gem_name}.json`
    raise NameError if result.nil?
    json = JSON.parse(result)
    json.map { |v| v['number'] }
  rescue JSON::ParserError
    print "\n\nConnection failed. Check out internet.\n"
  rescue NameError
    print "It seems there is no gem with such name.\n"
  end
end
