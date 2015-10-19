require 'colored'

class Visualiser

  def initialize(versions)
    @versions = versions
  end

  def visualise(filter)
    @versions.each do |version|
      if filter.include?(version)
        puts version.red
      else
        puts version
      end
    end
  end
end
