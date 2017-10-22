class Output
  
  def self.outprint(total_results, total_links)
    scores = {wins: 0, loses: 0}
    total_results.each_with_index do |hash, i|
      scores = print_res(hash, total_links[i], scores)
    end
    puts print_scores(scores) if !ENV["NAME"].nil?
  end

  private

    def self.print_scores(scores)
      "#{ENV['NAME']} wins #{scores[:wins]} times, loses #{scores[:loses]} times."
    end

    def self.print_text(first_arr, last_arr, total_link, scores)
      puts "#{first_arr[0]} vs #{last_arr[0]} - #{total_link}"
      puts "#{first_arr[0]} - #{first_arr[1]}"
      puts "#{last_arr[0]} - #{last_arr[1]}"
      if first_arr[1] > last_arr[1]
        log = "#{first_arr[0]} WINS!"
      elsif first_arr[1] < last_arr[1]
        log = "#{last_arr[0]} WINS!"
      else
        log = "DRAW or No information..."
      end
      if log.include? "#{ENV['NAME']}"
        scores[:wins] += 1
      elsif log != "No information..."
        scores[:loses] += 1
      end
      puts log
      puts
      scores
    end

    def self.print_res(hash, total_link, scores)
      first_arr = hash.first
      last_arr = hash.delete(first_arr.first)
      last_arr = hash.first
      scores = print_text(first_arr, last_arr, total_link, scores)
      scores
    end
end
