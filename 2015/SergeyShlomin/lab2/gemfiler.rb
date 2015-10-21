#!/usr/bin/env ruby
begin
Dir[File.expand_path("..", __FILE__) +'/lib/*.rb'].each { |f| require_relative f }
  gem_name = nil
  input_version = []
  if ARGV.empty?
    fail ArgumentError.new 'Incorrect input data. use: <gem name> <filter>? <filter>?'
  else
    if ARGV.count  == 2 || ARGV.count  == 3
      gem_name = ARGV[0]
      i=1
      while i < ARGV.count do
        vers = ARGV[i].split(/ /)
        if ['>=', '<=', '~>', '<', '>'].include? vers[0]
          vers.each { |e| input_version.push e }
        elsif true
          input_version[0] = nil
          input_version[1] = vers[0]
        end
        i+=1
      end
      #p gem_name
      #p input_version
      fetched_gems = Gem_fetcher.fetch(gem_name)
      Gem_printer.new(fetched_gems, Gem_filter.new(fetched_gems, input_version).filter).print
    elsif ARGV.count  == 1
      gem_name = ARGV[0]
      Gem_printer.new(Gem_fetcher.fetch(gem_name), []).print
    else
      fail ArgumentError.new 'Incorrect input data. use: <gem name> <filter>? <filter>?'
    end
  end
rescue ArgumentError => e
  puts 'ArgumentError'
  if e.message.include? "Malformed version number string"
    puts "incorrect gem version"
  else
    puts  e.message
  end
rescue NameError => e
  puts 'NameError'
  if e.message.include? "uninitialized constant"
    puts "Cannot found modules in lib"
  else
    puts  e.message
  end
rescue Exception => e
  puts 'Other exception'
  puts e.message
  puts e.backtrace.inspect
end
