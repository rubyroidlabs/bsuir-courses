require 'optparse'

module GemVersionsFilter
  class ArgsParser
    def self.parse(cli_arguments)
      options = {}

      options_parser = OptionParser.new do |opts|
        opts.on('-g', '--gem GEM_NAME', 'Gem name') do |gem_name|
          options[:gem_name] = gem_name
        end

        opts.on('-v', '--vers v1,v2', Array, 'Versions') do |gem_versions|
          options[:versions] = gem_versions
        end

        opts.on('-h', '--help', 'Display help') do
          puts opts
          exit
        end
      end

      options_parser.parse!(cli_arguments)

      options

      rescue StandardError => error
        puts "Exception was handled #{error}"
    end
  end
end
