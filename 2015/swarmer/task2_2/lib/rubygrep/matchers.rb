module RubyGrep
  class Matcher
    attr_reader :context_lines

    def initialize(context_lines)
      @context_lines = context_lines
    end

    def search_task(task)
      matching_lines = []

      task.each_file do |file|
        matching_lines += search_file(file)
      end

      matching_lines
    end

    def search_file(file)
      lines = file.each_line.to_a
      matching_line_numbers = Set.new()

      lines.each_with_index do |line, i|
        if line_matches?(line)
          matching_line_numbers.merge((i - context_lines..i + context_lines))
        end
      end

      matching_line_numbers.select! { |i| (0..lines.size).include?(i) }

      lines.values_at(*matching_line_numbers)
    end
  end

  class TextMatcher < Matcher
    attr_reader :text_pattern

    def initialize(text_pattern, context_lines)
      super(context_lines)
      @text_pattern = text_pattern
    end

    def line_matches?(line)
      line.include?(@text_pattern)
    end
  end

  class RegexMatcher < Matcher
    attr_reader :regexp

    def initialize(regex_pattern, context_lines)
      super(context_lines)
      @regexp = Regexp.new(regex_pattern)
    end

    def line_matches?(line)
      @regexp =~ line
    end
  end
end
