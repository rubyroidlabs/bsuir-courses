class File_actors
  def initialize(file_name)
    @file_name = file_name
  end

  def file_entry(arr_actors)
    f = File.new(@file_name, 'w')
    arr_actors.each do |a|
      f.puts (a)
    end
    f.close
  end

  def file_read
    arr_artists = Array.new
    File.open(@file_name).each do |line|
      arr_artists << line
    end
    arr_artists
  end
end
