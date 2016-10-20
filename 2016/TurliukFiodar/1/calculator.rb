class RPNCalc
  def initialize(string)
    @string = string
    @numbers = []
  end
  def reverse
    symbols = []
    @string.split(" ").each do |i|
      if i=~ /\d/
        @numbers << i
        else
        symbols << i
    end
    
    symbols.each do |symbol| 
      first, second = @numbers.pop(2)
       @numbers << first.to_i symbol.to_sym second.to_i
    end
  end
  def display
    puts @numbers
  end
end

