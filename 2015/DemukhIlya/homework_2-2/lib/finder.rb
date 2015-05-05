require_relative 'file_contents'

class Finder

  def initialize(files)
  	@contents = []
  	files.each do |file|
  	  @contents << FileContents.new(file)
  	end
  end

  def find(pattern)
  	result = []
  	@contents.each do |contents|
  	  result += [contents.filename + ': '] + contents.lines.select { |line| line.include?(pattern) } 
  	end
  	result
  end

  def find_with_amount(pattern)
  	result = []
  	@contents.each do |contents|
  	  result += [contents.filename + ': ']
  	  contents.lines.each.with_index do |line, index|
  	  	if line.include?(pattern)
  	  	  line += " before: #{index}, after: #{contents.lines.length - index - 1}" 
  	  	  result << line
  	  	end
  	  end
  	end
  	result
  end

  def find_using_regexp(pattern)
  	result = []
  	@contents.each do |contents|
  	  result += [contents.filename + ': '] + contents.lines.select { |line| line =~ Regexp.new(pattern) } 
  	end
  	result
  end
end

