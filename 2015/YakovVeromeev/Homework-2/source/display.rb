require 'colored'

class Display
  def self.display(versions, filtered)
    versions.each do |version|
      if filtered.include?(version)
        puts version.red
      else
        puts version
      end
    end
  end
end
