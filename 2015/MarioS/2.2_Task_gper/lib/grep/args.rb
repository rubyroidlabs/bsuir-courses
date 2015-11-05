require 'optparse'

module Grep
  class Args
    def initialize(args)
      @args = args
    end

    def parse_argv
      @conditions = { amount: 0 }
      opt_parse
      @conditions[:pattern] = @args.shift
      @conditions[:fnames] ||= @args.shift.split unless @args.first.nil?
      validate_coditions
      @conditions
    end

    def opt_parse
      OptionParser.new do |opts|
        opts.banner = 'Usage: PATTERN + FILE + [options]'
        opts.separator '*You can set the PATTERN in RegExp format'
        opts.on('-A NLINES', Integer, 'Amount of context') do |amount|
          @conditions[:amount] = amount
        end
        opts.on('-f', '-files fn1,fn2..', Array, 'Files for search') do |files|
          @conditions[:fnames] = files
        end
        opts.on('-R', 'Recursion in the current directory') do |_|
          @conditions[:fnames] = Dir.glob('*').select { |f| File.file?(f) }
        end
        opts.on('-z zname', String, 'Gzip file for search') do |zname|
          @conditions[:zname] = zname
        end
      end.parse!(@args)
    end

    def validate_coditions
      if @conditions[:pattern].nil? ||
         (@conditions[:fnames].nil? && @conditions[:zname].nil?)
        fail 'Wrong conditions format.Use -h for help.'.red
      end
    end
  end
end
