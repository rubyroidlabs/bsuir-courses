require 'colorize'

class Console
  def input_a_letter_error
    puts 'You input a letter! Please press C and continue evaluations'.red
  end

  def current_definition(arr)
    puts 'Current definition'.blue
    arr.map { |e| puts e.to_s.yellow }
  end

  def cleared
    puts 'Cleared!'.green
    puts 'You can input new definition'.blue
  end

  def answer(answer)
    puts "ASWER: #{answer}".green
  end

  def invalid_notation
    puts "Invalid notation \nPlease press C and try again".red
  end
end
