class Output
  def self.outprint(total_results, total_links)
    scores = { wins: 0, loses: 0 }
    total_results.each_with_index do |hash, i|
      scores = print_res(hash, total_links[i], scores)
    end
    puts print_scores(scores) unless ENV['NAME'].nil?
  end

  def self.print_scores(scores)
    "#{ENV['NAME']} wins #{scores[:wins]}, loses #{scores[:loses]}."
  end

  def self.conditions_of_print(first_arr, last_arr)
    log = if first_arr[1] > last_arr[1]
            "#{first_arr[0]} WINS!"
          elsif first_arr[1] < last_arr[1]
            "#{last_arr[0]} WINS!"
          else
            'DRAW or No information...'
          end
    log
  end

  def self.increment_conditions(scores, log)
    if log.include? ENV['NAME'].to_s
      scores[:wins] += 1
    elsif log != 'No information...'
      scores[:loses] += 1
    end
    scores
  end

  def self.print_text(first_arr, last_arr, total_link, scores)
    puts "#{first_arr[0]} vs #{last_arr[0]} - #{total_link}"
    puts "#{first_arr[0]} - #{first_arr[1]}"
    puts "#{last_arr[0]} - #{last_arr[1]}"
    log = conditions_of_print(first_arr, last_arr)
    scores = increment_conditions(scores, log)
    puts log
    puts
    scores
  end

  def self.print_res(hash, total_link, scores)
    first_arr = hash.first
    hash.delete(first_arr.first)
    last_arr = hash.first
    scores = print_text(first_arr, last_arr, total_link, scores)
    scores
  end
end
