
class Battle
  attr_accessor :song, :rappers, :text

  def initialize(song_page, song)
    @song = song
    rappers = song['title'].split(/vs\.?/i)
    @rappers = rappers.map { |i| i.gsub(/\s+/, '') }
    @text = song_page.search('.lyrics p').text
  end

  def count_words(text, word)
    text.scan(/(\W|^)#{word}(\W|$)/i).size
  end

  def count_elements(text, i, cryteria)
    sum = 0
    until text[i].nil?
      sum += (cryteria.nil? ? text[i].length : count_words(text[i], cryteria))
      i += 2
    end
    sum
  end

  def count(cryteria)
    text = @text.split(/\[Round [123].+\]\n/)
    text.shift
    text = text.map { |i| i.gsub(/\s+/, '') } if cryteria.nil?
    @number1 = count_elements(text, 0, cryteria)
    @number2 = count_elements(text, 1, cryteria)
  end

  def output
    if @text.nil? || @rappers.any?(&:nil?)
      puts 'Error'
      return
    end
    puts "#{@rappers.first} - #{@number1}\n#{@rappers.last} - #{@number2}"
    if @number1 > @number2
      puts "#{@rappers.first} WINS!"
    elsif @number1 < @number2
      puts "#{@rappers.last} WINS!"
    elsif @number1 == @number2
      puts 'DRAW!'
    end
  end

  def win?(name)
    if rappers.first == name
      @number1 > @number2
    elsif rappers.last == name
      @number2 > @number1
    end
  end
end
