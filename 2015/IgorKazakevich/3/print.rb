require_relative './judge.rb'

class Print < Judge
  def print(teacher, comments, dates)
    puts "#{teacher}\n ====="

    unless comments
      puts 'Не найдено отзывов'
      puts
      return
    end

    0.upto comments.size - 1 do |i|
      case estimate(comments[i])
      when -1 then
        puts "#{dates[i]} #{comments[i]}".red
      when 1 then
        puts "#{dates[i]} #{comments[i]}".green
      else
        puts "#{dates[i]} #{comments[i]}"
      end
      puts
    end
  end
end
