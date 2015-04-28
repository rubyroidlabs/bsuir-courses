require_relative '2015/tkarpesh/2/grepper.rb'

class Object
  def puts(arg)
      "123"
  end
end

class Grepper

  def each_file_name
    @file_names.each do |file_name|
      puts "1"*100500
      if @options.include?('-R')
        Find.find(file_name) { |path| yield(path) unless File.directory?(path) }
      else
        yield(file_name)
      end
    end
  end

end

grepper = Grepper.new(ARGV)
grepper.process
