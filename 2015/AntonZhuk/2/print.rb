require 'colored'

class Print
  def initialize(filtered_versions, versions)
    @filtered_versions = filtered_versions
    @versions = versions
    print_result
  end

  def print_result
    @versions.each do |ver|
      if @filtered_versions.include?(ver)
         puts ver.red
      else
         puts ver
      end
    end
  end
end
