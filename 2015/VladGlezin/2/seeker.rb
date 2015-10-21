require 'gems'

Dir["./*.rb"].each {|file| require file}

class Seeker
  attr :arr, :name

  def initialize(name)
    @arr= Array.new
    @name = name
  end
  def seek
    begin
      temp = Gems.versions(@name)
      temp.each do |hash|
        hash.each do |k, v|
          @arr.push(v) if k == "number"
        end
      end
    rescue
      puts "No such gem!"
    end
  end
end