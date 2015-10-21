require 'colorize'

# Implements methods for output.
class Writer
  def self.write_to_console(versions, filtered_versions)
    versions.each do |version|
      if filtered_versions.include? version
        puts version.red
      else
        puts version
      end
    end
  end
end
