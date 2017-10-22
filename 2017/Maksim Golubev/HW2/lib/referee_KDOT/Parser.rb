require 'optparse'

class Parser
  def initialize(args)
    @args = args.dup
  end

  def parse
    params = OptionParser.new do |opts|
      opts.banner = 'Usage: ./demo.rb NAME'
    end.parse!(@args)

    find_in_params(params)
  end

  def find_in_params(params)
    return {} if params.empty?
    in_params = {}
    params.each do |param|
      in_params[:name] = param.match(/NAME=(\w*)/)[1] if param =~ /NAME=(\w*)/
      if param =~ /CRITERIA=(\w*)/
        in_params[:criteria] = param.match(/CRITERIA=(\w*)/)[1]
      end
    end
    in_params
  end
end
