require_relative 'parse.rb'
require 'json'

module Base
  def creation
    data_info = JSON.generate(Names.new.load_names)
    data_file = File.new('data.json', 'w')
    data_file.puts(data_info)
    data_file.close
  end

  def reading
    data_file = File.read('data.json')
    data_info = JSON.parse(data_file)
    data_info
  end
end
