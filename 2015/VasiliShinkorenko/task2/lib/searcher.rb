require 'json'

class Searcher

  def initialize(gem_name)
    @gem_name = gem_name
  end

  def search
    begin
      result = `curl https://rubygems.org/api/v1/versions/#{@gem_name}.json`
      raise NameError if result.nil?
      json = JSON.parse(result)
      json.map { |v| v['number'] }
    rescue JSON::ParserError => json_error
      print "\n\nConnection failed. Check out internet.\n"           
    rescue NameError => name_error
      print "It seems there is no gem with such name.\n"
    end
  end

end