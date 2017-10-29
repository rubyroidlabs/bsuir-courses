require_relative 'new_parser.rb'
SIZE_OF_TEXT = 6 # кол-во куплетов должно быть 6 по условию задачи
# class for job with rap
class RapProcessing
  def initialize(count_pages, count)
    @t = Parse.new(count_pages, count)
    @text = @t.parse_round_of_text
    @name1 = @t.name_of_the_raper(1)
    @name2 = @t.name_of_the_raper(0)
    @name_of_battle = @t.parse_links_of_text(1)
  end

  def winner
    if @text.size >= SIZE_OF_TEXT
      count_of_first_raper = @text[1].size + @text[3].size + @text[5].size
      count_of_second_raper = @text[2].size + @text[4].size + @text[6].size
      puts "Название батла: #{@name_of_battle}"
      puts "у #{@name1}: #{count_of_first_raper} букв,а у #{@name2}: #{count_of_second_raper}"
      if count_of_first_raper > count_of_second_raper
        puts "победил #{@name1}"
      else
        puts "победил #{@name2}"
      end
    else
      puts "Название батла: #{@name_of_battle}"
      puts 'Текста нету или не подходит под шаблон'
    end
    puts '=' * 20
  end
end
