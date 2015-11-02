require 'curb'
require 'json'
require 'colorize'

class VersionFinder
  def initialize(name)
    @name = name
  end

  def vget
    begin
      adress = "https://rubygems.org/api/v1/versions/#{@name}.json"
      versions = Curl::Easy.http_get(adress).body_str
      rescue Curl::Err::HostResolutionError
        puts '(╯°□°)╯︵ ┻━┻ (check your network connection)'.red
        exit
      end

    begin
      json = JSON.parse(versions)
      json.map! { |v| v['number'] }
      rescue JSON::ParserError
        puts '(╯°□°)╯︵ ┻━┻ (invalid gem name)'.red
        exit
      end
  end
end
