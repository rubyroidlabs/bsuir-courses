require 'readline'
require_relative 'console.rb'
require_relative 'integer.rb'
require 'rubocop'

class Calc
  def initialize
    @definition = ''
    @input = nil
    @current_def = []
    @console = Console.new
    @count_of_operations = 0
    @count_of_variables = 0
  end

  def start
    loop do
      read
      if it_operation?
        transform if @current_def.size >= 3
        @console.current_definition @current_def
        @count_of_operations += 1
      elsif checked?
        @count_of_variables += 1
      end
      calculate
    end
  end

  def read
    @input = Readline.readline('=> '.red)
    clear_buffer_if_need
    @current_def.push(@input) if checked?
  end

  def clear_buffer_if_need
    if @input.include?('c') | @input.include?('C')
      @input = ''
      @definition = ''
      @current_def = []
      @count_of_variables = 0
      @count_of_operations = 0
      @console.cleared
    end
  end

  def it_operation?
    @input.end_with?('*', '-', '+', '/', '!') ? true : false
  end

  def transform
    @current_def[@current_def.size - 3] = "(#{@current_def[@current_def.size - 3]}#{@current_def[@current_def.size - 1]}#{@current_def[@current_def.size - 2]})"
    @current_def[@current_def.size - 2], @current_def[@current_def.size - 1] = @current_def[@current_def.size - 1], @current_def[@current_def.size - 2]
    @current_def = @current_def[0..@current_def.size - 3]
  end

  def correct_notation?
    (@count_of_variables - @count_of_operations == 1) && (@count_of_operations != 0) ? true : false
  end

  def calculate
    if correct_notation?
      @current_def.each do |elem|
        @definition = elem.to_s + @definition
      end
      @console.answer eval(@definition).to_s
    else
      @definition = ''
    end

    rescue SyntaxError
      @console.invalid_notation
    end

  def checked?
    @console.input_a_letter_error unless @input.slice(/[a-zA-Z]+/).eql?(nil)
    @input.insert(0, '.') if @input.eql?('!')
    !@input.eql?('') ? true : false
  end
end
