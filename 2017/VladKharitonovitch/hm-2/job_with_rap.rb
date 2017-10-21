require 'rubygems'
require 'mechanize'
require 'json'
class RapProcessing
  def initialize(rap, batlle)
    @rap = rap
    @name_of_battle_local = batlle
  end
  @count_of_first_raper = 0
  @count_of_second_raper = 0
  def character_count(rap)
    freqs = 0
    rap.each_char { |char| freqs += 1}
    freqs
  end
  def winner
    if @rap.length <=2  
      puts "Подсчёт невозможен для #{@name_of_battle_local}"
      puts "Отсутствует текст на странице!"
      puts '='*20
    elsif @rap.length == 3
      puts "Название рэп-баттла : #{@name_of_battle_local}"
      puts "Тут всего 3 куплета,кто выиграл сказать сложно"
      puts '='*20
    elsif @rap.length == 4
      puts "Название рэп-баттла : #{@name_of_battle_local}"
      puts "Тут всего 3 куплета,кто выиграл сказать сложно"
      puts '='*20
    elsif @rap.length == 5
      puts "Название рэп-баттла : #{@name_of_battle_local}"
      puts "Тут всего 4 куплета,кто выиграл сказать сложно,но скорее всего первый рэпер"
      puts '='*20
    elsif @rap.length == 6
      @count_of_first_raper = character_count(@rap[0]) + character_count(@rap[2]) + character_count(@rap[4])
      @count_of_second_raper = character_count(@rap[1]) + character_count(@rap[3]) + character_count(@rap[5])
      if @count_of_first_raper > @count_of_second_raper
        puts "Название рэп-баттла : #{@name_of_battle_local}"
        puts "У первого рэпера #{@count_of_first_raper} букв,а у второго #{@count_of_second_raper} букв "
        puts 'Победил первый рэпер'
        puts '='*20
      else
        puts "Название рэп-баттла : #{@name_of_battle_local}"
        puts "У первого рэпера #{@count_of_first_raper} букв,а у второго #{@count_of_second_raper} букв "
        puts 'Победил второй рэпер'
        puts '='*20
      end
    elsif @rap.length == 7
      @count_of_first_raper = character_count(@rap[1]) + character_count(@rap[3]) + character_count(@rap[5])
      @count_of_second_raper = character_count(@rap[2]) + character_count(@rap[4]) + character_count(@rap[6])
      if @count_of_first_raper > @count_of_second_raper
        puts "Название рэп-баттла : #{@name_of_battle_local}"
        puts "У первого рэпера #{@count_of_first_raper} букв,а у второго #{@count_of_second_raper} букв "
        puts 'Победил первый рэпер'
        puts '='*20
      else
        puts "Название рэп-баттла : #{@name_of_battle_local}"
        puts "У первого рэпера #{@count_of_first_raper} букв,а у второго #{@count_of_second_raper} букв "
        puts 'Победил второй рэпер'
        puts '='*20
      end
    elsif @rap.length == 8
      @count_of_first_raper = character_count(@rap[0]) + character_count(@rap[2]) + character_count(@rap[4]) + character_count(@rap[6])
      @count_of_second_raper = character_count(@rap[1]) + character_count(@rap[3]) + character_count(@rap[5]) + character_count(@rap[7])
      if @count_of_first_raper > @count_of_second_raper
        puts "Название рэп-баттла : #{@name_of_battle_local}"
        puts "У первого рэпера #{@count_of_first_raper} букв,а у второго #{@count_of_second_raper} букв "
        puts 'Победил первый рэпер'
        puts '='*20
      else
        puts "Название рэп-баттла : #{@name_of_battle_local}"
        puts "У первого рэпера #{@count_of_first_raper} букв,а у второго #{@count_of_second_raper} букв "
        puts 'Победил второй рэпер'
        puts '='*20
      end  
    elsif @rap.length == 9
      @count_of_first_raper = character_count(@rap[1]) + character_count(@rap[3]) + character_count(@rap[5]) + character_count(@rap[7])
      @count_of_second_raper = character_count(@rap[2]) + character_count(@rap[4]) + character_count(@rap[6]) + character_count(@rap[8])
      if @count_of_first_raper > @count_of_second_raper
        puts "Название рэп-баттла : #{@name_of_battle_local}"
        puts "У первого рэпера #{@count_of_first_raper} букв,а у второго #{@count_of_second_raper} букв "
        puts 'Победил первый рэпер'
        puts '='*20
      else
        puts "Название рэп-баттла : #{@name_of_battle_local}"
        puts "У первого рэпера #{@count_of_first_raper} букв,а у второго #{@count_of_second_raper} букв "
        puts 'Победил второй рэпер'
        puts '='*20
      end
    elsif @rap.length == 10
      @count_of_first_raper = character_count(@rap[0]) + character_count(@rap[2]) + character_count(@rap[4]) + character_count(@rap[6]) + character_count(@rap[8])
      @count_of_second_raper = character_count(@rap[1]) + character_count(@rap[3]) + character_count(@rap[5]) + character_count(@rap[7]) + character_count(@rap[9])
      if @count_of_first_raper > @count_of_second_raper
        puts "Название рэп-баттла : #{@name_of_battle_local}"
        puts "У первого рэпера #{@count_of_first_raper} букв,а у второго #{@count_of_second_raper} букв "
        puts 'Победил первый рэпер'
        puts '='*20
      else
        puts "Название рэп-баттла : #{@name_of_battle_local}"
        puts "У первого рэпера #{@count_of_first_raper} букв,а у второго #{@count_of_second_raper} букв "
        puts 'Победил второй рэпер'
        puts '='*20
      end  
    elsif @rap.length == 11
      @count_of_first_raper = character_count(@rap[1]) + character_count(@rap[3]) + character_count(@rap[5]) + character_count(@rap[7]) + character_count(@rap[9])
      @count_of_second_raper = character_count(@rap[2]) + character_count(@rap[4]) + character_count(@rap[6]) + character_count(@rap[8]) + character_count(@rap[10])
      if @count_of_first_raper > @count_of_second_raper
        puts "Название рэп-баттла : #{@name_of_battle_local}"
        puts "У первого рэпера #{@count_of_first_raper} букв,а у второго #{@count_of_second_raper} букв "
        puts 'Победил первый рэпер'
        puts '='*20
      else
        puts "Название рэп-баттла : #{@name_of_battle_local}"
        puts "У первого рэпера #{@count_of_first_raper} букв,а у второго #{@count_of_second_raper} букв "
        puts 'Победил второй рэпер'
        puts '='*20
      end
    else
      puts "что-то не так с этим батлом,подсчёт будет неточен"
      @count_of_first_raper = character_count(@rap[1]) + character_count(@rap[3]) + character_count(@rap[5])
      @count_of_second_raper = character_count(@rap[2]) + character_count(@rap[4]) + character_count(@rap[6])
      if @count_of_first_raper > @count_of_second_raper
        puts "Название рэп-баттла : #{@name_of_battle_local}"
        puts "У первого рэпера #{@count_of_first_raper} букв,а у второго #{@count_of_second_raper} букв "
        puts 'Победил первый рэпер'
        puts '='*20
      else
        puts "Название рэп-баттла : #{@name_of_battle_local}"
        puts "У первого рэпера #{@count_of_first_raper} букв,а у второго #{@count_of_second_raper} букв "
        puts 'Победил второй рэпер'
        puts '='*20
      end
    end
  end
end