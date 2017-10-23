# Printer
class PrettyPrinter
  def print_info(battles)
  	puts battles.size
    battles.each do |battle|
      puts '---------------------------------------------------------------'
      puts "#{battle.title} (#{battle.link})".blue
      puts "#{battle.left_mc.name} - #{battle.left_mc.letters_count}".yellow
      puts "#{battle.right_mc.name} - #{battle.right_mc.letters_count}".green
      puts "#{battle.winner.name} WINS!!!".red
    end
  end
end
