require 'yaml'
require 'colorize'
require 'unicode'

class Print
  def initialize(lectors)
    @lectors = lectors
    begin
    @keywords = YAML.load(File.open('keywords.yml'))
    rescue ArgumentError => e
      puts "Could not parse YAML: #{e.message}"
    end
  end

  def print_data
    @lectors.each_pair do |name, comments|
      puts name
      puts '======='
      comments.each do |comment|
        case tonality(comment)
        when -1
          puts comment.colorize(:red)
        when 1
          puts comment.colorize(:green)
        else
          puts comment
        end
      end
      puts
    end
  end

  def tonality(comment)
    positive = 0
    negative = 0
    @keywords['negative'].each do |keyword|
      if Unicode::downcase(comment).include?(keyword)
        negative += 1
      end
     end
    @keywords['positive'].each do |keyword|
      if Unicode::downcase(comment).include?(keyword)
        positive += 1
      end
    end
    positive <=> negative
  end
end