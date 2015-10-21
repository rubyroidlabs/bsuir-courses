require 'gems'
class GemVersions
  def initialize(gem)
    begin
    Gems.configure do |config|
      config.username = 'antonn.lida@mail.ru'
      config.password = '3163510fF'
    end
    Gems.api_key
    @gem = gem
    @versions_array = []
    rescue StandardError => exc
      puts exc.message
      exit
    end
  end

  def get_version()
    begin
    Gems.versions(@gem).each do |vers|
      @versions_array << vers["number"]
    end
    rescue StandardError => exc
    puts exc.message
    exit
    end
    @versions_array
  end
end
