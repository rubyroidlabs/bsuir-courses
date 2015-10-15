require 'curses'
Curses.init_screen
def max_size_engine
  @maxsize = 0
  0.upto(ENGINE_FIRST.size - 1) do |i|
    @l = ENGINE_FIRST[i].size
    if @maxsize < @l
      @maxsize = @l
    end
  end
  return @maxsize
end
