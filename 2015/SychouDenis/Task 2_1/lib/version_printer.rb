require 'colorize'

class VersionPrinter
  def self.print_all_version(versions)
    versions.each do |k, v|
      if v == true
        puts ('+' + k).green
      else
        puts ('-' + k).red
      end
    end
  end

  def self.print_only_matched(versions)
    versions.each do |k, v|
      puts ('+' + k).green if v == true
    end
  end
end
