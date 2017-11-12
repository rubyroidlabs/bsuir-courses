require 'redis'
require 'fileutils'
require 'pry'
require_relative 'data_downloader.rb'

class RedisClient < Redis

  DUMP_FILE = './data/persons.rdb'

  def refresh_data
    if File.file?(DUMP_FILE)
      load_from_file(DUMP_FILE)
    else
      persons = DataDownloader.new.download
      load_persons(persons)
      dump_persons(DUMP_FILE)
    end
  end

  def name_by_pattern(pattern)
    next_i = '0'
    result = []
    begin
      respond = sscan('nameset',next_i, match: pattern)
      next_i = respond.first
      result << respond.last
    end while !next_i.to_i.zero?
    result.flatten
  end

  def comment_by_name(name)
    return hget('persons',"#{name}")
  end

  def all_names
    smembers 'nameset'
  end


  private

  def load_from_file(file)
    data = File.open(DUMP_FILE) { |file| file.read }
    del 'persons'
    restore('persons', '0', data)
    names = hkeys 'persons'
    del 'nameset'
    sadd('nameset', names)
  end

  def load_persons(persons)
    del 'persons'
    del 'nameset'
    names = persons.keys
    comments = persons.values
    hmset('persons', names.zip(comments).flatten)
    sadd('nameset', persons.keys)
  end

  def dump_persons(file)
    dir = DUMP_FILE.sub(/\/[^\/]+$/, '')
    FileUtils::mkdir_p dir unless File.exists?(dir)
    File.open(file, 'w') { |file| file.write(dump('persons')) }
  end
end

# binding.pry
