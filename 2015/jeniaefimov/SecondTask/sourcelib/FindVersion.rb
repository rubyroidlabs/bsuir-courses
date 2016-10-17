require 'json'

class FindVersion
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def find
    result = `curl https://rubygems.org/api/v1/versions/#{name}.json`
    json = JSON.parse(result)
    json.map { |s| s['number'] }
  end
end
