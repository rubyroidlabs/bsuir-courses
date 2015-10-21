require 'colorize'

class Printer
  def self.print(suitable_versions, available_versions)
    available_versions.each do |variable|
      if suitable_versions.intersect?(Set[variable.text])
        puts variable.text.red
      else
        puts variable.text
      end
    end
  end
end
