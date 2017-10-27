require './battle.rb'

class Printer
  def initialize(link)
    @rappers = Battle.new(link).rappers
    @rounds = Battle.new(link).rounds
  end

  def print_default(envname)
    puts @rappers[0]
    puts @rappers[1] + ' - ' + @rounds[2].to_s
    puts @rappers[2] + ' - ' + @rounds[3].to_s

    if !envname.nil?
      if @rounds[2] > @rounds[3]
        puts "#{@rappers[1]} WINS"
        puts
        envname == @rappers[1] ? 'win' : 'lose'
      else
        puts "#{@rappers[2]} WINS"
        puts
        envname == @rappers[1] ? 'lose' : 'win'
      end
    elsif envname.nil?
      if @rounds[2] > @rounds[3]
        puts "#{@rappers[1]} WINS"
      else
        puts "#{@rappers[2]} WINS"
      end
      puts
    end
  end

  def print_envname(envname)
    if @rappers.include? envname
      print_default(envname)
    else
      false
    end
  end

  def print_envcrit(envcrit)
    count_crit1 = @rounds[0].scan(envcrit).size
    count_crit2 = @rounds[1].scan(envcrit).size

    puts @rappers[0]
    puts "#{@rappers[1]} - #{count_crit1}"
    puts "#{@rappers[2]} - #{count_crit2}"

    if count_crit1 > count_crit2
      puts "#{@rappers[1]} WINS!"
    elsif count_crit1 < count_crit2
      puts "#{@rappers[2]} WINS!"
    else
      puts 'Choose other criteria'
    end
    puts
  end

  def print_envcrit_envname(envname, envcrit)
    count_crit1 = @rounds[0].scan(envcrit).size
    count_crit2 = @rounds[1].scan(envcrit).size

    if @rappers.include? envname
      puts @rappers[0]
      puts "#{@rappers[1]} - #{count_crit1}"
      puts "#{@rappers[2]} - #{count_crit2}"

      if count_crit1 > count_crit2
        puts "#{@rappers[1]} WINS"
        puts
        envname == @rappers[1] ? 'win' : 'lose'
      else
        puts "#{@rappers[2]} WINS"
        puts
        envname == @rappers[2] ? 'win' : 'lose'
      end
    else
      false
    end
  end
end
