require_relative 'lib_file_two.rb'
require_relative 'lib_repeat_two.rb'


class Reading
  def mix
    txt = File_actors.new('description.txt')
    arr_description = txt.file_read

    txt_name = File_actors.new('actors.txt')
    arr_name = txt_name.file_read

    a = Repition.new
    count = a.count(arr_name)

    array_actors = Array.new

    name_count = 0
    arr_name.each do |i|
      name_count += 1
      if name_count < count
        arr_description.each do |a|
          data = i + arr_description[name_count-1]
          array_actors.push(data)
          break
        end
      else
        data = i + "No information"
        array_actors.push(data)
      end
    end

    array_actors
  end
end
