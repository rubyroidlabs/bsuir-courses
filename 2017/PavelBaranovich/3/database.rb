class Database
  attr_accessor :info

  def initialize
    @info = []
  end

  def load_from_file(file_name)
    File.open(file_name, 'r') do |file|
      file.each do |line|
        @info.push(line)
      end
    end
  end

  def upload_to_file
    File.open('database.txt', 'w') do |file|
      file.puts @info
    end
  end
end
