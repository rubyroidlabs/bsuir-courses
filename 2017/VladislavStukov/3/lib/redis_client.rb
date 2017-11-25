require 'redis'
require 'fileutils'
require_relative 'data_downloader.rb'

class RedisClient < Redis
  DUMP_FILE = '../data/persons.rdb'.freeze

  def refresh_data
    if File.file?(DUMP_FILE)
      load_from_file
    else
      persons = DataDownloader.new.download
      load_persons(persons)
      dump_persons(DUMP_FILE)
    end
  end

  def name_by_pattern(pattern)
    next_i = '0'
    result = []
    loop do
      respond = sscan('nameset', next_i, match: pattern)
      next_i = respond.first
      result << respond.last
      break if next_i.to_i.zero?
    end
    result.flatten
  end

  def comment_by_name(name)
    hget('persons', name.to_s)
  end

  def all_names
    smembers 'nameset'
  end

  def scan_names
    next_i = '0'
    loop do
      respond = sscan('nameset', next_i)
      next_i = respond.first
      respond.last.each { |name| yield(name) }
      break if next_i.to_i.zero?
    end
  end

  private

  def load_from_file
    data = File.open(DUMP_FILE).read
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

  def dump_persons(filename)
    dir = DUMP_FILE.sub(%r{\/[^\/]+$}, '')
    FileUtils.mkdir_p dir unless File.exist?(dir)
    File.open(filename, 'w') { |file| file.write(dump('persons')) }
  end
end
