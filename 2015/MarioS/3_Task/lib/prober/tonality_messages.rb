require 'colorize'
require 'yaml'

module LectorsProber
  class TonalityMessages
    SEPARATOR = '======='.red

    def initialize(lectors_info)
      @lectors_info = lectors_info.dup
      @tonality = YAML.load_file('config/default.yml')
    end

    def analysis_tonality
      positive_matchers = @tonality['positive']
      negative_matchers = @tonality['negative']
      @lectors_info.each  do |lector|
        lector[:comments].map! do |comment|
          pos = entries_count(comment, positive_matchers)
          neg = entries_count(comment, negative_matchers)
          result = pos - neg
          identify_tone(comment, result)
        end
      end
      @lectors_info
    end

    def entries_count(comment, matchers)
      matchers.reduce(0) { |amount, e| amount + comment.scan(/#{e}/i).size }
    end

    def identify_tone(comment, result)
      if result > 0
        comment.green
      elsif result < 0
        comment.red
      else
        comment
      end
    end

    def to_s
      lectors = analysis_tonality
      lectors_info = ''
      lectors.each do |lector|
        lectors_info << "\n#{lector[:name].cyan}#{SEPARATOR}\n"
        lectors_info << lector[:comments].join("\n\n")
      end
      lectors_info
    end
  end
end
