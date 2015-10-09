# ходит в нет за версиями
class Fetcher
  require 'json'

  def initialize(name)
    @name = name
  end

  def fetch
    result = `curl https://rubygems.org/api/v1/versions/#{@name}.json`
    json = JSON.parse(result)
    json.map { |s| s['number'] }
  end
end
