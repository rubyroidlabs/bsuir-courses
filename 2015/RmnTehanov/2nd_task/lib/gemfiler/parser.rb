require 'slop'

class Parser
  def initialize(args)
    @args = args
  end

  def parse_param
    Slop.parse(@args) do |o|
      o.banner = "Usage: ./run.rb GEM_NAME [gem_version].\nExample:
      ./run.rb devise '~> 2.1.3'
      ./run.rb rails '>= 3.1'
      ./run.rb rails '>= 3.1' '< 4.0'"
      o.on '-h', '--help', 'Help info' do
        puts o
        exit
      end
    end
    gem_name = @args.shift
    conditions = []
    @args.each { |item| conditions << item }
    { name: gem_name, conditions: conditions }
  end
end
