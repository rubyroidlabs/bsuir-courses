require 'game_life'

class GameOfLifeConsole < GameOfLife

  def print
    pr = ""
    @field.each { |row| pr += row.join('') + "\n" }
    pr.gsub!('1', '▓')
    pr.gsub!('0', ' ')
    puts pr
  end

  def loop_print (sleep_time)
    loop do
      print
      step
      sleep sleep_time
      puts "e[H\e[2J"
    end
  end
end
