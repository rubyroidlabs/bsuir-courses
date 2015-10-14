pic = %w(______________O ________/\__O __/\__/\__O ________/\__O)

loop do	
count = 0
  until count == 4
	pic.each do |item|
	  system 'clear'
	  case count
	    when 1
	  	  item.insert(0, "  ")
	    when 2, 3
	  	  item.insert(0, "    ")
	      pic[1].insert(0, "  ") if count == 2
	  end
	  puts item
	  item.insert(0, "    ") if count == 0
	  count += 1
	  sleep (0.3)
    end
  end
end