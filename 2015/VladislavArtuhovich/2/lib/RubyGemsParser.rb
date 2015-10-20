require 'gems'
require 'colored'

class RubyGemsParser
  def getGemVersions(gemName)
    gemsArray = Gems.versions gemName
    if gemsArray.empty?
      fail "Not existing gem."
    end
    gemsArray.map {|v| v['number']}.uniq
  rescue StandardError => e
    puts e.message.red
  end
end 
