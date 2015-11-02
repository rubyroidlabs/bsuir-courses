class ArgumentParser
  attr_reader :options
  def initialize
    @options = { help: false }
  end

  def parse
    if ARGV.size == 0
      options[:help] = true
      return options
    end
    OptionParser.new do |opts|
      opts.banner = 'Usage: bsuir_reviews [options]'

      opts.on('-h') do
        options[:help] = true
      end
    end
    options
  end
end
