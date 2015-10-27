#!/usr/bin/env ruby
require 'optparse'

begin
  Dir[File.expand_path("..", __FILE__) + '/lib/*.rb'].each do |f|
    require_relative f
  end
  input_version = []
  parser = OptionParser.new do |opts|
    opts.banner = "Usage: ./gemfiler.rb [gem name] [gem version] [gem version]
      Example:  ./gemfiler.rb devise '~> 2.1.3'
                ./gemfiler.rb rails '>= 3.1'
                ./gemfiler.rb rails '>= 3.1' '< 4.0'
                ./gemfiler.rb devise '2.1.3'
                ./gemfiler.rb devise"
    opts.on('-h', '--help', 'help') do
      puts opts
    end
  end
  parse_argv = parser.parse!
  if parse_argv.empty? || parse_argv.count > 3
    fail ArgumentError.new 'Input argument error'
  else
    if !parse_argv.count == 1
      gem_name = parse_argv[0]
      i = 1
      while i < parse_argv.count
        vers = parse_argv[i].split(/ /)
        if ['>=', '<=', '~>', '<', '>'].include? vers[0]
          vers.each { |e| input_version.push e }
        elsif vers[1].nil?
          input_version[0] = nil
          input_version[1] = vers[0]
        else
          fail ArgumentError.new 'Input gem indicator error'
        end
        i += 1
      end
      # p gem_name
      # p input_version
      fetched_gems = GemFetcher.fetch(gem_name)
      GemPrinter.new(fetched_gems,
                     GemFilter.new(fetched_gems, input_version).filter
                    ).print
    else
      gem_name = parse_argv[0]
      GemPrinter.new(GemFetcher.fetch(gem_name), []).print
    end
  end

rescue ArgumentError => e
  puts 'ArgumentError'
  if e.message == 'Input argument error'
    puts 'Неверно указаны входные параметры, воспользуйтесь шаблоном ниже'
    puts parser.banner
  elsif e.message == 'Input gem indicator error'
    puts 'Неправильно указан идентификатор версии гема'
    puts parser.banner
  elsif e.message.include? 'Malformed version number string'
    puts 'incorrect gem version'
  else
    puts e.message
  end
rescue NameError => e
  puts 'NameError'
  if e.message.include? 'uninitialized constant'
    puts 'Cannot found modules in lib'
    puts e.message
  else
    puts e.message
  end
end
