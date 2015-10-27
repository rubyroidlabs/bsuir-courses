require 'colorize'

class Printer
  def print_versions(hash_of_versions)
    hash_of_versions.each do |k, v|
      if v
        puts k.red
      else
        puts k
      end
    end
  end
end
