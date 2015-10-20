require 'open-uri'
require 'colorize'

class URLParse
  @slice_range = 0..32
  @filter_pattern = '/versions/'

  def initialize(url)
    begin
      @content = URI.parse(url).read
    rescue OpenURI::HTTPError => ex
      puts 'Invalid url ;('
      exit
    end
  end

  def find_versions
    #divide into array of tags
    array = @content.split('>').select! { |str|  str[@filter_pattern] }
    # a class="t-list__item" href="https://rubygems.org/gems/gems/versions/0.8.1" => https://rubygems.org/gems/gems/versions/0.8.1 => 0.8.1
    return array.each { |str| str.slice!(@slice_range) && str.slice!(str.length - 1)  && str.sub!(@url, "")}
  end

  def self.find_versions(url)
    begin
      content = URI.parse(url).read
    rescue OpenURI::HTTPError => ex
      puts 'Invlid url ;('
      exit
    end
    array = content.split('>').select! { |str|  str[@filter_pattern] }
    return array.each { |str| str.slice!(@slice_range) && str.slice!(str.length - 1)  && str.sub!(url, "") && str.sub!('/', "")}
  end
end

class InputSecure
  def self.check?(stream)
    if (stream.size > 3)
      puts 'Invalid input => stream size'
      exit
    end
    (stream.size - 1).times do |i|
      begin
      	Gem::Dependency.new('', stream[i + 1]).match?('', '1.0.0')
      rescue ArgumentError => ex
        puts "Invalid input => #{stream[i + 1]}"
        exit
      end
	end
	begin
      URI.parse("https://rubygems.org/gems/#{stream[0]}/versions").read
    rescue OpenURI::HTTPError => ex
      puts 'Invalid game name ;( try again'
      exit
    end
    return true
  end
end

class InputParse
  def initialize(stream)
    @stream = stream
    @option_count = stream.size - 1
    @gem_name = stream[0]
  end

  def gem_name
    @gem_name
  end

  def option_count
    @option_count
  end

  def filter_options
    filter_options = case @option_count
      when 1 
        @stream[1]
      when 2
        @stream[1..2]
      else 
       @stream[1]
      end
  end
end

class Filter
  def initialize(list, filter_options)
    @list = list
    if filter_options.size == 2 
      @filter_method = lambda { |x| return true if Gem::Dependency.new('', filter_options[0]).match?('', x) && Gem::Dependency.new('', filter_options[1]).match?('', x) } 
    else
      @filter_method = lambda { |x| return true if Gem::Dependency.new('', filter_options).match?('', x) }
    end
  end

  def output 
    @list.each do |element|
      if @filter_method.call(element)
        puts element.colorize(:green)
      else 
        puts element
      end
    end
  end
end

input_parse = InputParse.new(ARGV) if InputSecure.check?(ARGV)
versions = URLParse.find_versions("https://rubygems.org/gems/#{input_parse.gem_name}/versions")
filter = Filter.new(versions, input_parse.filter_options)
filter.output
