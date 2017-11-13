require 'colorize'

class PrettyPrinter
  def print_info(battles)
    battles.each do |battle|
      puts '---------------------------------------------------------------'
      puts "#{battle.title} (#{battle.link})".blue
      puts "#{battle.left_mc.name} - #{battle.left_mc.mc_text_letters_count}"
        .yellow
      puts "#{battle.right_mc.name} - #{battle.right_mc.mc_text_letters_count}"
        .green
      if battle.winner
        puts "#{battle.winner.name} WINS!!!".red
      else
        puts 'Tie!!!'.red
      end
    end
  end
end
