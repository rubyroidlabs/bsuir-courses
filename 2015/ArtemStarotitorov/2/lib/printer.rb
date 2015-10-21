require 'colorize'

class Printer
  def self.print_versions(hash_of_versions)
    hash_of_versions.each do |k, v|
      if v == true
        puts k.red
      else
        puts k
      end
    end
  end
end
