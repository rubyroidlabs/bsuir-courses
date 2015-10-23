require 'open-uri'
require 'json'
require 'colored'
class VersionGet
  def initialize(name)
    @name = name
  end

  def collect
    begin
      versions = open("https://rubygems.org/api/v1/versions/#{@name}.json").read
      JSON.parse(versions).map { |ver| ver['number'] }
    rescue OpenURI::HTTPError
      puts 'Check gem name'.red
    rescue SocketError
      puts 'Check your internet connection'.red
    end
  end
end
