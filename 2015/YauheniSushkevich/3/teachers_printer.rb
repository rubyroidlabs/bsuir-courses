# Prints teachers and comments about them
# with color based on sentiment analysys
class TeachersPrinter
  def self.print(teachers)
    teachers.each do |teacher|
      puts "\n#{teacher[:last_name]} #{teacher[:first_name][0]}. #{teacher[:middle_name][0]}."
      if !teacher[:comments].empty?
        teacher[:comments].each do |comment|
          print_colored comment
        end
      else
        puts 'Отзывов не найдено'
      end
    end
  end

  def self.print_colored(comment)
    case SentimentAnalyzer.analyze comment[:text]
    when 'POSITIVE' then puts "#{comment[:time]}: #{comment[:text].green}"
    when 'NEUTRAL' then puts "#{comment[:time]}: #{comment[:text].white}"
    when 'NEGATIVE' then puts "#{comment[:time]}: #{comment[:text].red}"
    end
  end
end
