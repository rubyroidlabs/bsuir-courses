class RapParser
  def initialize(raper_name)
    @raper = { name: raper_name, wins: 0, loses: 0 }
  end

  def process(rap_params) # title, link, full_text, criteria
    if rap_params[:full_text].scan(/\n/).size < 2 # no text check
      puts "#{rap_params[:title]} - #{rap_params[:link]}"
      puts rap_params[:full_text]
      return
    end
    rap_params[:full_text].gsub!(/\[…\]/, '')
    rounds = rap_params[:full_text].scan(/\[[^?\]]+\]/) # get order of texts
    if rounds.empty? # check non-standard round names
      mixed_texts = rap_params[:full_text].split(/Round \d: .+/)
      rounds = rap_params[:full_text].scan(/Round \d: .+/)
      rounds.map! do |round|
        round.sub!(/Round \d: /, '')
        round.capitalize
      end
    else
      mixed_texts = rap_params[:full_text].split(/\[[^?\]]+\]/)
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
    if rounds.empty? # irregular pattern of round names
      puts "#{rap_params[:title]} - #{rap_params[:link]}"
      puts rap_params[:full_text]
      return
    end
    mixed_texts.shift
    named_texts = {}
    # hash with sorted rapers text
    rounds.uniq.each { |name| named_texts[name] = '' }
    rounds.size.times { |i| named_texts[rounds[i]] += mixed_texts[i].to_s }
    # search for the winner by criteria
    criteria = rap_params[:criteria] ? /#{rap_params[:criteria]}/ : /\w/
    name_rate = {}
    named_texts.each_pair { |name, text| name_rate[name] = text.scan(criteria).size }
    puts "#{rap_params[:title]} - #{rap_params[:link]}"
    name_rate.each_pair { |name, rate| puts "#{name.capitalize} - #{rate}" }
    winner = name_rate.max_by { |name, rate| rate }
    puts "#{winner[0].capitalize} WINS!"
    puts '=' * 100
    if @raper[:name]
      if winner[0].casecmp(@raper[:name]).zero?
        @raper[:wins] += 1
      else
        @raper[:loses] += 1
      end
    end
  end

  def print_statistic
    print "#{@raper[:name].capitalize} "
    puts "wins #{@raper[:wins]} times, loses #{@raper[:loses]} times."
  end
end
