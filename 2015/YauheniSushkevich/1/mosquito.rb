mosquito = []
mosquito[0] = "         
	   
      |\\|\\
___.-.| \\ |
   `-.`-'`.___
      `--'\\  _\\_
           \\_\\  `-.
              `-."
mosquito[1] = "


___.-._._
   `-.\\ |`.___
      `\\|'\\  _\\_
           \\_\\  `-.
              `-."

def mosquito.width
  19
end

def mosquito.fly
  system 'clear'
  cols = `stty size`.split.map { |x| x.to_i }.reverse[0]
  (cols-self.width).downto(0) do |i|
  	self.each do |frame|
  	  frame.split("\n").each do |string|
	  	puts ' ' * i +	 string
  	  end
  	  system 'sleep 0.07'
      system 'clear'
  	end
  end
end

def mosquito.appear
  cols = `stty size`.split.map { |x| x.to_i }.reverse[0]
  (cols).downto(cols-self.width) do |i|
  	self.each do |frame|
  	  frame.split("\n").each do |string|
	  	puts ' ' * i +	 string[0, cols - i]
  	  end
  	  system 'sleep 0.07'
      system 'clear'
  	end
  end
end

def mosquito.disappear
  0.upto(self.width) do |i|
  	self.each do |frame|
  	  frame.split("\n").each do |string|
	  	puts string[i, string.length]
  	  end
  	  system 'sleep 0.07'
      system 'clear'
  	end
  end
end

mosquito.appear
mosquito.fly
mosquito.disappear