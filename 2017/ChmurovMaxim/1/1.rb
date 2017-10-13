    a = [47,[[27,[[14,[[14,[[46,[[36,[[34,[6,33]],[15,[44,1]]]],[10,[[28,[20,39]],[48,[37,28]]]]]],[0,[[20,[[42,[20,12]],[22,[37,8]]]],[9,[[3,[41,45]],[28,[22,39]]]]]]]],[29,[[44,[[12,[[13,[48,13]],[39,[34,47]]]],[18,[[44,[10,47]],[23,[11,35]]]]]],[0,[[4,[[45,[23,29]],[37,[49,5]]]],[16,[[3,[37,26]],[26,[21,45]]]]]]]]]],[48,[[20,[[6,[[35,[[34,[23,30]],[24,[23,38]]]],[3,[[22,[35,39]],[40,[40,32]]]]]],[49,[[0,[[23,[14,47]],[43,[21,19]]]],[46,[[41,[23,28]],[38,[1,3]]]]]]]],[42,[[31,[[20,[[16,[38,48]],[33,[5,15]]]],[43,[[2,[4,4]],[23,[4,30]]]]]],[1,[[29,[[21,[42,22]],[13,[10,11]]]],[47,[[21,[24,4]],[13,[26,14]]]]]]]]]]]],[33,[[16,[[25,[[23,[[29,[[20,[43,12]],[44,[7,5]]]],[40,[[34,[47,0]],[25,[33,13]]]]]],[25,[[30,[[43,[36,31]],[35,[31,27]]]],[17,[[41,[6,16]],[1,[31,14]]]]]]]],[31,[[48,[[32,[[20,[34,44]],[42,[33,38]]]],[28,[[31,[41,32]],[3,[20,12]]]]]],[3,[[4,[[35,[3,43]],[22,[3,40]]]],[30,[[26,[46,31]],[25,[28,7]]]]]]]]]],[48,[[46,[[14,[[3,[[27,[14,14]],[30,[18,9]]]],[39,[[0,[48,6]],[13,[3,16]]]]]],[15,[[17,[[32,[19,45]],[37,[37,21]]]],[44,[[11,[46,28]],[18,[26,7]]]]]]]],[34,[[14,[[48,[[39,[19,40]],[18,[22,22]]]],[43,[[45,[27,2]],[11,[34,32]]]]]],[27,[[44,[[9,[27,45]],[26,[47,32]]]],[29,[[10,[11,42]],[47,[5,9]]]]]]]]]]]]]]

    levels = {}
     
     
    def func(arr, levels, level) 
      if arr.is_a? Fixnum
        if levels["#{level}"].is_a? Array
          levels["#{level}"] << arr
        else
          levels["#{level}"] = [arr]
        end
      else
        func(arr.first, levels, level+1)
        func(arr.last, levels, level+1)
      end
    end
     
    func(a, levels, 0)
     
    max = (levels[levels.keys.last].count)*8
     
    #puts levels.each { |_, numbers| p numbers }
     
    levels.keys.each do |key|
      count = levels[key].count * 2
      interval = max / count
      #puts "#{count} count #{interval} interval"
     
      index = 1
      if (levels[key].count > 1)
        levels[key].each do |value|
     
          slash_interval_right = interval / 2
          slash_interval_right -= 1
          slash_interval_left = interval / 2
     
          if (index % 2 == 0)
            slash = '\\'
          else 
            slash = '/'
          end
     
          index += 1
     
          print "#{' '*slash_interval_right}#{slash}#{' '*slash_interval_left}"
        end
      end
     
      puts
     
      levels[key].each do |value|
     
        interval_right = interval / 2
        interval_right -= 1
        if value.to_s.length == 1
          interval_left = interval / 2
        else
          interval_left = interval / 2
          interval_left -= 1
        end
     
        print "#{" "*interval_right}#{value}#{" "*interval_left}"
      end
      puts
    end
