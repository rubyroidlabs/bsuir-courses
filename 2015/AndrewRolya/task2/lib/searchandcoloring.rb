require 'colorize'
class SearchAndColoring
  def initialize(input_text, input_hash)
    @s_input_text = input_text
    @s_input_hash = input_hash
  end
  def search_and_coloring
    @s_input_text.size.times do |i|
      result = true
      @s_input_hash.each do |key,value|
        unless @s_input_text[i].send(key.to_sym,value) && result == true
          result = false
        end
      end
      if result
        puts @s_input_text[i].to_s.red
      else
        puts @s_input_text[i]
      end
    end
  end
end
