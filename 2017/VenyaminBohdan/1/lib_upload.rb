require_relative 'lib_pars.rb'
require_relative 'lib_file.rb'

class Upload
  def surfing
    actors = Actors.new
    arr_actors = actors.search

    txt = File_actors.new('actors.txt')
    txt.file_entry(arr_actors)
    txt
  end
end

