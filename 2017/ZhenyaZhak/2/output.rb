class OutputBatler
  INCORRECT_VALUE = 2
  F_B = 0
  S_B = 1

  def self.puts_batler(count_batler, name_batler, link_uri)
    name_b = ENV['NAME'] ? ENV['NAME'].downcase : ' '
    count = INCORRECT_VALUE
    if count_batler.any?(&:zero?) && !ENV['CRITERIA']
      return INCORRECT_VALUE
    end
    if count_batler[F_B] == count_batler[S_B]
      str = 'Dead heat!!!'
    else
      x = count_batler[F_B] > count_batler[S_B] ? F_B : S_B
      str = "#{name_batler[x]} REAL NIGGA!!!"
      count = name_b == name_batler[x].downcase ? F_B : S_B
    end
    puts "\n#{name_batler[F_B]} vs #{name_batler[S_B]} - #{link_uri}
#{name_batler[F_B]} - #{count_batler[F_B]}
#{name_batler[S_B]} - #{count_batler[S_B]}\n#{str}\n"
    count
  end

end
