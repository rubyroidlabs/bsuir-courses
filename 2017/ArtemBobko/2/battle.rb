class  Battle
  attr_accessor :rappers, :text

  def initialize(song_page, song)
    rappers = song['title'].split(/[Vv]s/)
    @rappers = rappers.map { |i| i.gsub(/\s+/, '') }
    @text = song_page.search('.lyrics p').text
  end

  def count(text, i)
    sum = 0
    until text[i].nil?
      sum += text[i].length
      i += 2
    end
    sum
  end

  def count_symbols()
    text = @text.split(/\[Round [123].+\]\n/)
    text.shift
    text.map { |i| i.gsub(/\s+/, '') }
    @number1 = count(text, 0)
    @number2 = count(text, 1)
  end

  def output()
    if @text.nil? || @rappers[1].nil?
      puts 'Error'
      return
    end
    print "#{@rappers[0]} - "
    puts @number1
    print "#{@rappers[1]} - "
    puts @number2
    if @number1 > @number2
      puts "#{@rappers[0]} WINS!"
    elsif @number1 < @number2
      puts "#{@rappers[1]} WINS!"
    elsif @number1 == @number2
      puts 'DRAW!'
    end
    puts
  end

  def is_win?(name)
    if (@number1 > @number2) && (rappers[0] == name)
      true
    elsif ((@number1 < @number2) && (rappers[1] == name) )
      true
    else
      false
    end
  end

end
