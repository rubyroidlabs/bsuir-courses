require 'colored'

class OutputVersions
  def initialize(gem_versions, user_versions)
    @gem_versions, @user_versions = gem_versions, user_versions
    output_to_terminal
  end

  def output_to_terminal
    @gem_versions.each do |version|
      if @user_versions.include?(version)
        p version.red
      else 
        p version
      end
    end
  end
end