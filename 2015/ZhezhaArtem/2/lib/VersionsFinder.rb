class VersionFinder
  attr_accessor :gem, :version, :versions_array
  def initialize(gem)
    Gems.configure do |config|
      config.username = '531621@mail.com'
      config.password = 'asdasd123123'
    end
    Gems.api_key
    @gem = gem
  end

  def get_vers_from_serv()
    begin
      Gems.versions(@gem)
      rescue StandardError => exc
      puts exc.message
      exit
    end
  end
end