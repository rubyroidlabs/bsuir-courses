require 'colored'
class Print
  def initialize(versions, find_versions)
    @versions = versions
    @find_versions = find_versions
  end

  def print_versions
    @versions.each do |version|
      if @find_versions.include? @versions.index(version)
        puts version.to_s.red
      else
        puts version.to_s
      end
    end
  end
end
