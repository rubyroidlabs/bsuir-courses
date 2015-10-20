require 'colored'
module Colorizer
  def self.colorize_matched(versions)
    versions.each do |k, v|
      if v == true
        puts k.green
      else
        puts k.red
      end
    end
  end
end
