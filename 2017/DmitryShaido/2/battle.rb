require 'mechanize'
class Battle
  attr_accessor :mc1, :mc2, :mc1_sum, :mc2_sum, :link

  def initialize(link)
    @link = link.uri
    @mc1 = link.to_s.split('vs')[0].strip
    @mc2 = link.to_s.split('vs')[1].partition('(')[0]
    @mc1_sum = 0
    @mc2_sum = 0
  end

  def print_results
    puts
    puts "#{@mc1} vs#{@mc2} - #{@link}"
    puts "#{@mc1} - #{@mc1_sum}"
    puts "#{@mc2.strip} - #{@mc2_sum}"
    winner = get_winner
    puts "#{winner} WINS!"
  end

  def get_winner
    @mc1_sum > @mc2_sum ? @mc1.strip : @mc2.strip
  end

  def final_results(criteria = nil)
    agent = Mechanize.new
    page = agent.get(@link)
    lyrics = page.css('.lyrics p').to_s.split('<br>')
    mc_flag = 0
    if !criteria.nil?
      lyrics.each do |string|
        string = string.strip
        mc_flag = 1 if string.include?('Round') && string.include?(@mc1.strip)
        mc_flag = 2 if string.include?('Round') && string.include?(@mc2.strip)
        if (mc_flag == 1) && (string.size < 150)
          @mc1_sum += string.scan(criteria).size
        elsif (mc_flag == 2) && (string.size < 150)
          @mc2_sum += string.scan(criteria).size
        end
      end
    else
      lyrics.each do |string|
        string = string.strip
        mc_flag = 1 if string.include?('Round') && string.include?(@mc1.strip)
        mc_flag = 2 if string.include?('Round') && string.include?(@mc2.strip)
        if (mc_flag == 1) && (string.size < 150)
          @mc1_sum += string.size
        elsif (mc_flag == 2) && (string.size < 150)
          @mc2_sum += string.size
        end
      end
    end
  end
end
