require 'colored'

class Presentation
  def initialize(checked_versions)
    @checked_versions = checked_versions
  end

  def show_versions
    @checked_versions.each do |current_version|
      if current_version.class == String
        puts current_version.red
      else
        puts current_version
      end
    end
  end
end
