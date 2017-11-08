require 'json'
require 'fuzzy_match'
Dir['libs/*.rb'].each { |file| require File.expand_path(file) }

class CelebrityController
  DB_PATH = File.expand_path('db/celebrity.txt')

  attr_reader :celebrities

  def initialize
    @celebrities = read_from_file
    update
  end

  def update
    threads = []
    sources = [RankerParser.new, NewNowNextParser.new, IMDBParser.new]
    sources.each do |source|
      threads << Thread.new(source) do |parser|
        parser.parse.each { |celebrity| add(celebrity) }
      end
    end
    threads.each(&:join)
    synchronize_file
  end

  def search_by_name(name, banned_names = [])
    names = @celebrities.map { |celebrity| celebrity['name'] }
    names -= banned_names
    match = FuzzyMatch.new(names).find(name)
    return if match.nil?
    search_by_exact_name(match)
  end

  def search_by_exact_name(name)
    return nil if @celebrities.empty?
    @celebrities.detect { |celebrity| celebrity['name'] == name }
  end

  private

  def read_from_file
    return [] if File.zero? DB_PATH
    JSON.parse(File.open(DB_PATH, 'r', &:read))
  end

  def synchronize_file
    File.open(DB_PATH, 'w') { |file| file.write(@celebrities.to_json) }
  end

  def exist?(celebrity)
    if search_by_exact_name(celebrity['name']).nil?
      false
    else
      true
    end
  end

  def add(celebrity)
    return if exist? celebrity
    @celebrities << celebrity
  end
end
