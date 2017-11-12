require_relative 'lib_pars.rb'
require_relative 'lib_pars_two.rb'

class Repition
  def count(array)
    name_count = 0
    array.each do |i|
      name_count += 1
      if i.include? 'Neil Patrick'
        return name_count
      end
    end
  end

  def name_list
    first_pars = Actors.new
    first_array_name = first_pars.search

    second_array_name = Array.new
    arr = Array.new
    second_pars = Celebrety.new(second_array_name, arr)
    second_pars.find_gays

    result_array = second_array_name + first_array_name
    result_array.uniq!
  end
end
