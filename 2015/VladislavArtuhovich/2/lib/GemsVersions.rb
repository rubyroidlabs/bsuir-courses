require 'colored'

class GemsVersions
  def showVersions(gemsArr, firstCondition, secondCondition = '')
    gemsArr.each do |vers|
      if (isVersionUnderCondition(vers, firstCondition) &&
          isVersionUnderCondition(vers, secondCondition))
        puts vers.red
      else
        puts vers
      end
    end
  end

  def isVersionUnderCondition(version, condition)
    Gem::Dependency.new('', condition).match?('', version.gsub(/[.][a-z]+[0-9]/, ''))
  end
end
