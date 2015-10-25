require 'colorize'
class Print_Result
  def initialize(processed_list)
    @processed_list = processed_list
  end
  def printer
    if @processed_list.size == 0
      raise 'Incorrect interval.'
    end
    @processed_list = @processed_list.compact
    0.upto(@processed_list.size-1) do |i|
      if @processed_list[i]['color'].rindex('excluded')
        puts @processed_list[i]['version'].green
      else
        puts @processed_list[i]['version'].red
      end
    end
  end
end
