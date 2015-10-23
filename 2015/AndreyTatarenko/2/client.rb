require 'httparty'
require 'json'
require 'colorize'

class Client
  def initialize(gem_name)
    @uri = "https://rubygems.org/api/v1/versions/#{gem_name}.json"
  end

  def get_response
    HTTParty.get(@uri).to_s
    rescue SocketError
      abort('Check your internet connection!'.red)
    rescue JSON::ParserError
      abort('This is no such gem on rubygems.org!'.red)
  end

  def get_gem_list
    get_response.scan(/(?<=\"number\"\=\>\").*?(?=\")/)
  end
end
