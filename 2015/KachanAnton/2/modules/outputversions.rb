require 'colorize'
class OutputVersions
  def self.output_versions(hash_of_versions)
    hash_of_versions.each do |vers, value|
      value == true
        puts vers.red
      else
        puts vers
      end
    end
  end
end
