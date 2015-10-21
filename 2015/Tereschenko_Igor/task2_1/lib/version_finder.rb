require 'curb'
require 'json'
require 'colorize'

class VersionFinder
  def initialize(name)
    @name = name
  end

  def vget
    begin
      versions = Curl::Easy.http_get("https://rubygems.org/api/v1/versions/#{@name}.json").body_str
    rescue Curl::Err::HostResolutionError
      puts 'Error aquired! Please, check your network connection.'.red
      exit
    end

    begin
      json = JSON.parse(versions)
      json.map! { |v| v['number'] }
      rescue JSON::ParserError
        puts '(╯°□°)╯︵ ┻━┻ AAAAAAAAAAAAAARGH!!! (invalid gem name)'.red
        exit
      end
  end
end
