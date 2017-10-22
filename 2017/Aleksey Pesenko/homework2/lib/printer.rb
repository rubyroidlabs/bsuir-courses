class Analysis
  def output(player)
    puts "#{@first} vs #{@second} #{@url[@index]}"
    puts "#{@first} - #{player[0]}"
    puts "#{@second} - #{player[1]}"
    if player[0] > player[1]
      puts "#{@first} WINS!"
      if @first.include? ENV['NAME']
        @win += 1
      else
        @lose += 1
      end
    else
      puts "#{@second} WINS!"
      if @first.include? ENV['NAME']
        @lose += 1
      else
        @win += 1
      end
    end
    puts
  end
end
