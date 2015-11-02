Dir['../lib/*.rb'].each { |file| require file }

require 'sentiment_lib'
require 'microsoft_translator'
require 'colorize'
require 'yaml'
require 'optparse'

class Solution
  def initialize
    cnf = YAML::load(File.open('../config.yml'))
    begin
      @translator = MicrosoftTranslator::Client.new(cnf['ID_CLIENT'], cnf['API_KEY'])
    rescue StandardError => exc
      puts exc.message
      exit
    end
    @analyser = SentimentLib::Analyzer.new
    @searcher = Searcher.new
  end

  def print_results(group)
    teachers = @searcher.search_for_teachers(group)
    teachers.each do |teacher|
      puts teacher
      puts '====='
      print_comments teacher
    end
  end

  private 

  def print_comments(teacher)
    comments = @searcher.search_for_comments(teacher)

    if comments.length != 0
      comments.each do |v|
        str = @translator.translate(v, 'ru', 'en', 'text/html')
        analysis_res = @analyser.analyze(str.strip)
        if analysis_res > 0
          puts v.green
        elsif analysis_res < 0
          puts v.red
        else
          puts v
        end
        puts
      end
    else
      puts 'Не найдено отзывов'
    end
    puts
  end
end

if ARGV.length != 1
  puts 'Wrong number of parameters'
  exit
end

parser = OptionParser.new do |opts|
  opts.banner = 'Usage: ./bsuir_reviews [group]'
  opts.on('-h', 'Help') do
    puts opts
    exit
  end
end
arguments = parser.parse!

Solution.new.print_results(arguments[0])
