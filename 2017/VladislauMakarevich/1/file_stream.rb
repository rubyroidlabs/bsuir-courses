class FileStream
  def get_parsed_file(file_name)
    file = File.read(file_name)
    JSON.parse(file)
  end
end