# Class for parsing input parameters
class InputParse
  def initialize(stream)
    stream.options do |opts|
      opts.banner = 'Usage: [gem_name] [filter_options]'
      opts.parse!
    end
    @gem_name, *@filter_options = stream
    @filter_options << '>= 0' if @filter_options.empty?
    # error handling
    if @gem_name.nil?
      puts 'Invalid input => empty gem name'
      exit
    end
    @filter_options.each do |opt|
      begin
        Gem::Dependency.new('', opt).match?('', '1.0.0')
      rescue ArgumentError
        puts "Invalid input => #{opt}"
        exit
      end
    end
  end

  attr_reader :gem_name
  attr_reader :filter_options
end
