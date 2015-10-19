require 'open-uri'
class Connection
  def initialize(address)
    @data = open(address)
  rescue Exception
    puts "Connection error, or this gem does not exist!"
    exit
  end

  def getData()
    return @data
  end
end
