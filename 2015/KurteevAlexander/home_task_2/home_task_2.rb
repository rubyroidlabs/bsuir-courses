require 'colorize'
require 'gems'

class INPUT_DATA
  attr :gem_namе, :mark1, :mark2

  def initialize(gem_name, mark1, mark2 = nil)
    @gem_name = gem_name
    @mark1 = mark1
    @mark2 = mark2
    @gem_version = []
    @gem_range = []
  end

  def gem_data_info
    @gem_data = Gems.versions @gem_name
    @gem_data_size = @gem_data.size - 1
    @gem_data = @gem_data.reverse
    0.upto(@gem_data_size) do |i|
      @gem_data[i] = @gem_data[i]['number']
    end
    @gem_data = @gem_data.uniq
    @gem_data_size = @gem_data.size - 1
    @equally_1 = false
    @equally_2 = false
  end

  def arguments
    if ARGV.size == 2
      @gem_range << @mark1.split[0]
      @gem_version << @mark1.split[1]
    elsif ARGV.size > 2
      @gem_range << mark1.split[0].to_s
      @gem_version << mark1.split[1]
      @gem_range << mark2.split[0].to_s
      @gem_version << mark2.split[1]
      if @gem_range[0].match('=')
        @equally_1 = true
      end
      if @gem_range[1].match('=')
        @equally_2 = true
      end
    end
  end

  def one_range
    if @gem_range[0].match('~')
      if @gem_range[0].match('>')
        @gem_range[0] = ">"
        @gem_range[1] = "<"
        @gem_version[1] = @gem_version[0].clone
        @next_version = @gem_version[1].split('.')
        @gem_version[1] = @gem_version[1].sub(@next_version[1],@next_version[1].next)
      else
        @gem_range[0] = "<"
        @gem_range[1] = ">"
      end
    else
      if @gem_range[0].match('<')
        @gem_version[1] = '000'
        @gem_version = @gem_version.reverse
        if @gem_range[0].match('=')
          @equally_2 = true
        end
      elsif @gem_range[0].match('>')
        @gem_version[1] = '999'
        if @gem_range[0].match('=')
          @equally_1 = true
        end
      end
    end
    p @gem_version[0]
    p @gem_version[1]
    p @gem_range
  end

  def execute
    b = @gem_version[0].split(".")
    g = @gem_version[1].split(".")
    @gem_data_more = []
    0.upto(@gem_data_size) do |i|
      a = @gem_data[i].split(".") 
      a.each_with_index do |c, index|
        if c.to_i > b[index].to_i
          @gem_data_more << @gem_data[i]
          break
        elsif c.to_i < b[index].to_i
          puts @gem_data[i]
          break
        else
           if (index == (a.size - 1))
            if @equally_1
              puts @gem_data[i].red 
            else
              puts @gem_data[i]
            end
          end
        end  
      end
    end
    0.upto(@gem_data_more.size - 1) do |i|
      a = @gem_data_more[i].split(".") 
      a.each_with_index do |c, index|
        if c.to_i > g[index].to_i
          puts @gem_data_more[i]
          break
        elsif c.to_i < g[index].to_i
          puts @gem_data_more[i].red
          break
        else
          if (index == (a.size - 1))
            if @equally_2
              puts @gem_data[i].red
            else
              puts @gem_data[i]
            end
          end
        end
      end
    end
  end  
end

begin
  if ARGV.empty?
    puts 'arguments are empty'
  elsif ARGV.size < 2
    puts 'invalid number of elements'
  else
    input_data = INPUT_DATA.new(ARGV[0], ARGV[1], ARGV[2])
    input_data.arguments
    input_data.gem_data_info
    if ARGV.size == 2
      input_data.one_range
    end
    input_data.execute
  end
ensure
end
