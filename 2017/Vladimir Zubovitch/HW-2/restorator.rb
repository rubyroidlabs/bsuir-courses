require_relative 'test.rb'
class Restorator
  def initialize 
    @a = Obhod.new
    @text = @a.reload
  end 
  def next 
    otvet=[]
    @text.each do |battle|
    battle = battle.gsub(/Round (1|2|3): /){''}
    battle = battle.gsub(/^$/ , '')
    battle = battle.split('[')
    mc_round=[]
    battle.each do |lvl|
      unless lvl.empty?
        mc_round += lvl.split(']')
      end
    end
    raper_1 = mc_round[0]
    raper_2 = mc_round[2]
    rs_1=0
    rs_2=0
    unless mc_round[2].nil?
      mc_round.size.times do |i|
        if raper_1 == mc_round[i]
          rs_1 += mc_round[i+1].size
        elsif raper_2 == mc_round[i]
          rs_2 += mc_round[i+1].size      
        end
      end
    otvet << [raper_1 , raper_2 , rs_1 , rs_2] 
    end
    end
    @text = @a.reload
    return otvet
  end
end

