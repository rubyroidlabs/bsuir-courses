require 'open-uri'
require 'colorize'

class URLParse
  @slice_range = 0..32
  @filter_pattern = '/versions/'
  def self.find_versions(url)
    begin
      content = URI.parse(url).read
    rescue OpenURI::HTTPError => ex
      puts 'Invlid url ;('
      exit
    end
    array = content.split('>').select! { |str| str[@filter_pattern] }
    array.each { |str| str.slice!(@slice_range) }
    array.each { |str| str.slice!(str.length - 1) && str.sub!(url, '') }
    array.each { |str| str.sub!('/', '') }
  end
end

class InputSecure
  def self.check(stream)
    (stream.size - 1).times do |i|
      begin
        Gem::Dependency.new('', stream[i + 1]).match?('', '1.0.0')
      rescue ArgumentError => ex
        puts "Invalid input => #{stream[i + 1]}"
        exit
      end
    end
    if stream.size > 3
      puts 'Invalid input => stream size'
      exit
    end
    begin
      URI.parse("https://rubygems.org/gems/#{stream[0]}/versions").read
    rescue OpenURI::HTTPError => ex
      puts 'Invalid game name ;( try again'
      exit
    end
    true
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
    case @option_count
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
      @filter_method = lambda do |x|
        if Gem::Dependency.new('', filter_options[0]).match?('', x) &&
           Gem::Dependency.new('', filter_options[1]).match?('', x)
          return true
        end
      end
    else
      @filter_method = lambda do |x|
        if Gem::Dependency.new('', filter_options).match?('', x)
          return true
        end
      end
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

input_parse = InputParse.new(ARGV) if InputSecure.check(ARGV)
url = "https://rubygems.org/gems/#{input_parse.gem_name}/versions"
versions = URLParse.find_versions(url)
filter = Filter.new(versions, input_parse.filter_options)
filter.output
