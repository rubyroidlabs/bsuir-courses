require_relative 'lib_pars.rb'
require_relative 'lib_pars_two.rb'
require_relative 'lib_file_two.rb'
require_relative 'lib_repeat_two.rb'
require_relative 'lib_read_two.rb'

class Upload
  def surfing
    array_name = Array.new
    array_descript = Array.new

    a = Celebrety.new(array_name, array_descript)
    a.find_gays

    actors = Repition.new
    arr_actors = actors.name_list

    txt = File_actors.new('actors.txt')
    txt.file_entry(arr_actors)

    descr = File_actors.new('description.txt')
    descr.file_entry(array_descript)
  end

  def data
    portrait = Reading.new
    arr_portraits = portrait.mix

    information = File_actors.new('data.txt')
    information.file_entry(arr_portraits)
  end
end
