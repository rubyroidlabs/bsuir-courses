require 'optparse'

module GemVersionsFilter

  class ArgsParser

    def self.parse(cli_arguments)
      begin
        options = {}

        options_parser = OptionParser.new do |opts|

          opts.on('-g', '--gem GEM_NAME', 'Require gem before executing') do |gem_name|
            options[:gem_name] = gem_name
          end

          opts.on('-v', '--versions v1,v2', Array, 'Require gem versions before executing') do |gem_versions|
            options[:versions] = gem_versions
          end

          opts.on('-h', '--help', 'Display help') do
            puts opts
            exit
          end
        end

        options_parser.parse!(cli_arguments)

        options
      rescue Exception => error
        puts "Exception was handled #{error}"
      end
    end
  end
end
