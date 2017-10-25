require_relative 'rapper'

class Battle
  attr_accessor :rapper1, :rapper2

  def divide_data(songs)
    artist1 = songs[:title].split(/[vV]s.?/)[0].strip
    artist2 = songs[:title].split(/[vV]s.?/)[1].strip
    text = songs[:text].split(/\[Round [123].+\]/)
    text1 = []
    text2 = []
    text.each_with_index do |value, index|
      if index.even?
        text2 << value
      else
        text1 << value
      end
    end
    rapper_data = []
    rapper_data << Rapper.new(artist1, text1)
    rapper_data << Rapper.new(artist2, text2)
    @rapper1, @rapper2 = rapper_data
  end

  def winner(songs)
    count1 = @rapper1.count_letters
    count2 = @rapper2.count_letters
    if songs[:title].include? ENV['NAME']
      puts "#{songs[:title]} - #{songs[:href]}"
      puts "#{@rapper1.nick} - #{count1}"
      puts "#{@rapper2.nick} - #{count2}"
      if count1 > count2
        puts "#{@rapper1.nick} WINS!"
      elsif count1 < count2
        puts "#{@rapper2.nick} WINS!"
      else
        puts 'DRAW!'
      end
      puts '*' * 100
    end
  end
end
