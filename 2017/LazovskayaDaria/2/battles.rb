

class Battles
  def initialize(battler_name)
    @battler = { name: battler_name, wins: 0, loses: 0 }
  end

  def process(rap_content) 
    if rap_content[:full_text].scan(/\n/).size < 2
      puts "#{rap_content[:title]} - #{rap_content[:link]}"
      puts rap_content[:full_text]
      return
    end
    rap_content[:full_text].gsub!(/\[…\]/, '')
    rounds = rap_content[:full_text].scan(/\[[^?\]]+\]/)
    if rounds.empty? 
      mixed_texts = rap_content[:full_text].split(/Round \d: .+/)
      rounds = rap_content[:full_text].scan(/Round \d: .+/)
      rounds.map! do |round|
        round.sub!(/Round \d: /, '')
        round.capitalize
      end
    else
      mixed_texts = rap_content[:full_text].split(/\[[^?\]]+\]/)
      rounds.map! do |round|
        round.sub!(/Round \d: /, '')
        round.sub!(/First Round:/, '')
        round.sub!(/Round \d\s?[-–] /, '')
        round.sub!(/Verse \d: /, '')
        round.sub!(/Intro: /, '')
        round.sub!(/The /, '')
        round.sub!(/\[/, '')
        round.sub!(/\]/, '')
        round.capitalize
      end
    end
    if rounds.empty? 
      puts "#{rap_content[:title]} - #{rap_content[:link]}"
      puts rap_content[:full_text]
      return
    end

    mixed_texts
    named_texts = {}
   rounds.uniq.each { |name| named_texts[name] = '' }
    rounds.size.times { |i| named_texts[rounds[i]] += mixed_texts[i].to_s }
  


    criteria = rap_content[:criteria] ? /#{rap_content[:criteria]}/ : /\w/


    name_rate = {}
    named_texts.each { |name, text| name_rate[name] = text.scan(criteria).size }
    puts "#{rap_content[:title]} - #{rap_content[:link]}"

    name_rate.each_pair { |name, rate| puts "#{name.capitalize} - #{rate}" }
    winner = name_rate.max_by { |_name, rate| rate }

puts '*' * 3
    puts "#{winner[0].capitalize} WINS!"
    puts '_' * 80
puts '_' * 80


    if @battler[:name]
      if winner[0].casecmp(@battler[:name])
        @battler[:wins] += 1
      else
        @battler[:loses] +=1
      end
    end
  end

  def result
    print "#{@battler[:name].capitalize} "
    puts "wins #{@battler[:wins]} times, loses #{@battler[:loses]} times."
  end
end
