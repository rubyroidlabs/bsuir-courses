require 'colored'
class Print
  def initialize(versions, findVersions)
    @versions = versions
    @findVersions = findVersions
  end

  def printVersions()
    @versions.each do |version|
      if(@findVersions.include? @versions.index(version))
        puts version.red
      else
        puts version
      end
    end
  end
end
