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
        if envname == @rappers[1]
          'win'
        else
          'lose'
        end
      else
        puts "#{@rappers[2]} WINS"
        puts
        if envname == @rappers[1]
          'win'
        else
          'lose'
        end
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
    if envname == @rappers[1] || envname == @rappers[1]
      w_l = print_default(envname)
      w_l
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
    elsif count1 < count2
      puts "#{@rappers[2]} WINS!"
    else
      puts 'Choose other criteria'
    end
    puts
  end

  def print_envcrit_envname(envname, envcrit)
    count_crit1 = @rounds[0].scan(envcrit).size
    count_crit2 = @rounds[1].scan(envcrit).size

    if envname == @rappers[1] || envname == @rappers[2]
      puts @rappers[0]
      puts "#{@rappers[1]} - #{count_crit1}"
      puts "#{@rappers[2]} - #{count_crit2}"

      if envname == @rappers[1]
        if count_crit1 > count_crit2
          puts "#{@rappers[1]} WINS"
          puts
          'win'
        else
          puts "#{@rappers[2]} WINS"
          puts
          'lose'
        end
      elsif envname == @rappers[2]
        if count_crit1 > count_crit2
          puts "#{@rappers[1]} WINS"
          puts
          'lose'
        else
          puts "#{@rappers[2]} WINS"
          puts
          'win'
        end
      end
    else
      false
    end
  end
end
