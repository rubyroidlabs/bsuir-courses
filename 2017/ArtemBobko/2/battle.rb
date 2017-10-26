class Battle
  attr_accessor :rappers, :text, :song

  def initialize(song_page, song)
    @song = song
    rappers = song['title'].split(/vs\.?/i)
    @rappers = rappers.map { |i| i.gsub(/\s+/, '') }
    @text = song_page.search('.lyrics p').text
  end

  def count_s(text, i)
    sum = 0
    until text[i].nil?
      sum += text[i].length
      i += 2
    end
    sum
  end

  def count_symbols
    text = @text.split(/\[Round [123].+\]\n/)
    text.shift
    text = text.map { |i| i.gsub(/\s+/, '') }
    @number1 = count_s(text, 0)
    @number2 = count_s(text, 1)
  end
  
  def output
    if @text.nil? || @rappers.any?(&:nil?)
      puts 'Error'
      return
    end
    print "#{@rappers.first} - #{@number1}\n"
    print "#{@rappers.last} - #{@number2}\n"
    if @number1 > @number2
      puts "#{@rappers.first} WINS!"
    elsif @number1 < @number2
      puts "#{@rappers.last} WINS!"
    elsif @number1 == @number2
      puts 'DRAW!'
    end
    puts
  end

  def win?(name)
    if (@number1 > @number2) && (rappers.first == name)
      true
    elsif (@number1 < @number2) && (rappers.last == name)
      true
    else
      false
    end
  end
end
