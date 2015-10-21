require 'gems'
class GemVersions
  def initialize(req_gem)
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
    @req_gem = req_gem
    @versions_array = []
  end

  def get_version
    begin
      Gems.versions(@req_gem).each do |vers|
        @versions_array << vers['number']
      end
    rescue StandardError => exc
      puts exc.message
      exit
    end
    @versions_array
  end
end
