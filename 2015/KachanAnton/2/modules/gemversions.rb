require 'gems'
class GemVersions
  def initialize(gem)
    begin
      Gems.configure do |config|
        config.username = 'antonn.lida@mail.ru'
        config.password = '3163510fF'
      end
      Gems.api_key
    rescue StandardError => exc
      puts exc.message
      exit
    end
    @gem = gem
    @versions_array = []
  end

  def get_version
    begin
      Gems.versions(@gem).each do |vers|
        @versions_array << vers['number']
      end
    rescue StandardError => exc
      puts exc.message
      exit
    end
    @versions_array
  end
end
