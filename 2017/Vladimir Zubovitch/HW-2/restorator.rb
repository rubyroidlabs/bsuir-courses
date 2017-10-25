require_relative 'test.rb'
class Restorator
  def initialize
    @a = Obhod.new
    @text = @a.reload
  end

  def next
    otvet = []
    @text.each do |battle|
      battle = battle.gsub(/Round (1|2|3): /) { '' }
      battle = battle.gsub(/^$/, '')
      battle = battle.split('[')
      mc_round = []
      battle.each do |lvl|
        unless lvl.empty?
          mc_round += lvl.split(']')
        end
      end
      raper1 = mc_round[0]
      raper2 = mc_round[2]
      next if mc_round[2].nil?
      rs1 = 0
      rs2 = 0
      mc_round.size.times do |i|
        if raper1 == mc_round[i]
          rs1 += mc_round[i + 1].size
        elsif raper2 == mc_round[i]
          rs2 += mc_round[i + 1].size
        end
      end
      otvet << [raper1, raper2, rs1, rs2]
    end
    @text = @a.reload
  end
end
