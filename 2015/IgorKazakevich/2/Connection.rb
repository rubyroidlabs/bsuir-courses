require 'open-uri'
class Connection
  def initialize(address)
    @data = open(address)
  rescue StandardError
    puts 'Connection error, or this gem does not exist!'
    exit
  end

  def get_data
    @data
  end
end
