Dir['./*.rb'].each { |file| require file }

class String
  def red
    "\e[1m\e[31m#{self}\e[0m"
  end
end

class Printer
  attr :arr, :name, :option1, :option2

  def initialize(array, name, option1, option2 = nil)
    @arr = array
    @name = name
    @option1 = option1
    @option2 = option2
  end

  def print_result
    puts 'Gem: ' + @name
    puts 'Versions: '
    checker = Checker.new(@name, @option1, @option2)
    arr.each do |ver|
      if checker.fits?(ver)
        puts ver.red
      else
        puts ver
      end
    end
  end
end
