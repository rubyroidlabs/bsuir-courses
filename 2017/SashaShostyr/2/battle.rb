require_relative 'parser'
require_relative 'rapper'

class Battle
  attr_accessor :name, :rapper1, :rapper2

  def start_battle(data, stats)
    texts_for_battle = data[:text].split(/\[Round [123].+\]/)
    texts_for_battle.shift
    count = texts_for_battle.count
    if data[:name] =~ /[vV]s.?/ && count.even? && count != 0
      @rapper1, @rapper2 = create_rappers(data)
    elsif stats.nil? || data[:name] =~ /#{stats.nickname}/
      puts data[:name] + ' - ' + data[:href]
      puts "I can\'t process this battle. Sorry(\n" + '.' * 60
      return
    end
    nick = stats.nickname
    print_result(data, stats) if stats.nil? || data[:name] =~ /#{nick}/
  end

  def create_rappers(data)
    name_rapper1 = data[:name].split(/[vV]s.?/)[0].strip
    name_rapper2 = data[:name].split(/[vV]s.?/)[1].strip
    text_for_battle = data[:text].split(/\[Round [123].+\]/)
    text_for_battle.shift
    text_player1 = []
    text_player2 = []
    text_for_battle.each_with_index do |e, i|
      if i.even?
        text_player1 << e
      else
        text_player2 << e
      end
    end
    result = []
    result << Rapper.new(name_rapper1, text_player1)
    result << Rapper.new(name_rapper2, text_player2)
  end

  def print_result(data, stats)
    rapper1_count = @rapper1.get_count
    rapper2_count = @rapper2.get_count
    puts "#{data[:name]} - #{data[:href]}"
    puts "#{@rapper1.nickname} - #{rapper1_count}"
    puts "#{@rapper2.nickname} - #{rapper2_count}"
    if rapper1_count > rapper2_count
      puts @rapper1.nickname + ' ' + "WINS!!!\n" + '.' * 60
      winner = @rapper1.nickname
    else
      puts @rapper2.nickname + ' ' + "WINS!!!\n" + '.' * 60
      winner = @rapper2.nickname
    end
    write_statistic(winner, stats) unless stats.nil?
  end

  def write_statistic(winner, stats)
    if winner.casecmp(stats.nickname).zero?
      stats.victories += 1
    else
      stats.losses += 1
    end
  end
end
