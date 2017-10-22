require './battle.rb'

class Printer
  def initialize(link)
    @arr_inf = Battle.new(link).arr_inf
    @arr_data = Battle.new(link).arr_data
  end

  def print_default(evnname)
    inf_battle = @arr_inf[0]
    before = @arr_inf[1]
    after = @arr_inf[2]
    count_letters1 = @arr_data[2]
    count_letters2 = @arr_data[3]

    puts inf_battle
    puts before + ' - ' + count_letters1.to_s
    puts after + ' - ' + count_letters2.to_s

    if evnname == before
      if count_letters1 > count_letters2
        puts "#{before} WINS"
        puts
        'win'
      else
        puts "#{after} WINS"
        puts
        'lose'
      end
    else
      if count_letters1 > count_letters2
        puts "#{before} WINS"
        puts
        'lose'
      else
        puts "#{after} WINS"
        puts
        'win'
      end
    end
  end

  def print_evnname(evnname)
    before = @arr_inf[1]
    after = @arr_inf[2]
    count_letters1 = @arr_data[2]
    count_letters2 = @arr_data[3]

    if evnname == before || evnname == after
      w_l = print_default(evnname)
      return w_l
    else
      return false
    end
  end

  def print_evncrit(evncrit)
    mc1 = @arr_data[0]
    mc2 = @arr_data[1]
    inf_battle = @arr_inf[0]
    before = @arr_inf[1]
    after = @arr_inf[2]

    count1 = mc1.scan(evncrit).size
    count2 = mc2.scan(evncrit).size

    puts inf_battle
    puts "#{before} - #{count1}"
    puts "#{after} - #{count2}"

    if count1 > count2
      puts "#{before} WINS!"     
    elsif count1 < count2
      puts "#{after} WINS!"          
    else
      puts 'Choose other criteria'
    end
      puts
  end

  def print_evncrit_evnname(evnname, evncrit)
    mc1 = @arr_data[0]
    mc2 = @arr_data[1]
    inf_battle = @arr_inf[0]
    before = @arr_inf[1]
    after = @arr_inf[2]

    count1 = mc1.scan(evncrit).size
    count2 = mc2.scan(evncrit).size

    if evnname == before || evnname == after
      puts inf_battle
      puts "#{before} - #{count1}"
      puts "#{after} - #{count2}"

      if evnname == before
        if count1 > count2
          puts "#{before} WINS"
          puts
          'win'
        else
          puts "#{after} WINS"
          puts
          'lose'
        end
      else
        if count1 > count2
          puts "#{before} WINS"
          puts
          'lose'
        else
          puts "#{after} WINS"
          puts
          'win'
        end
    end
      else
        return false
      end
  end
end
