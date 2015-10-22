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
    Gems.versions(@req_gem).map { |v| v['number'] }
  end
end
