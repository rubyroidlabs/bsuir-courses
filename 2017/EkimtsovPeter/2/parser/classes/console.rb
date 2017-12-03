# Output results into console
class Console
  def initialize(names, link, first_count, second_count, winner)
    @names = names
    @link = link
    @first_count = first_count
    @second_count = second_count
    @winner = winner
  end

  def display_results
    puts "#{@names.first} vs #{@names.last} | #{@link}"
    puts "#{@names.first} - #{@first_count}"
    puts "#{@names.last} - #{@second_count}"
    puts "#{@winner} wins!"
    puts '--------------------'
  end

  def self.display_wins_loses(hash)
    puts "Wins: #{hash[:wins]}"
    puts "Loses: #{hash[:loses]}"
    puts 'That\'s all folks'
  end
end
