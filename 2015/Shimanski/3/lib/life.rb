require 'colorize'
class Life
  def initialize(size)
    @matrix_size = size
    @matrix = Array.new(size) do |e|
      e = Array.new(size).map! do |t|
        e = rand < 0.5 ? 0 : 1
      end
    end
  end

  def create_clear_matrix(size)
    m = Array.new(size).map do |e|
      e = Array.new(size)
      e.map! do |t|
        t = 0
      end
    end
    m
  end

  def print_matrix
    system 'clear'
    0.upto(@matrix_size - 1) do |i|
      0.upto(@matrix_size - 1) do |j|
        print "*  ".cyan if @matrix[i][j] == 1
        print ".  ".cyan if @matrix[i][j] == 0
        #print "#{@matrix[i][j]}  "
      end
      puts ""
    end
  end

  def go
    button = ''
    while button != 'exit'
      print_matrix
      do_iteration
      button = gets.chomp!
    end
  end

  def do_iteration
    temp_matrix = create_clear_matrix(@matrix_size)
    0.upto(@matrix_size - 1) do |i|
      0.upto(@matrix_size - 1) do |j|
        new_elem(i, j, temp_matrix)
      end
    end
    @matrix = temp_matrix
  end

  def new_elem(i, j, temp_matrix)
    count = get_count_of_alive(i, j)
    case count
      when 0 || 1 || 4 || 5 || 6 || 7 || 8
        temp_matrix[i][j] = 0
      when 2
        temp_matrix[i][j] = @matrix[i][j]
      when 3
        temp_matrix[i][j] = 1
    end
  end

  def get_elem(i, j)
    @matrix[i][j]
  end

  def get_count_of_alive(i,j)
    count = 0
    if i != @matrix_size - 1 && j != @matrix_size - 1
      if get_elem(i - 1, j - 1) == 1
        count += 1
      end
      if get_elem(i - 1, j) == 1
        count += 1
      end
      if get_elem(i - 1, j + 1) == 1
        count += 1
      end
      if get_elem(i, j - 1) == 1
        count += 1
      end
      if get_elem(i, j + 1) == 1
        count += 1
      end
      if get_elem(i + 1, j - 1) == 1
        count += 1
      end
      if get_elem(i + 1, j + 1) == 1
        count += 1
      end
      if get_elem(i + 1, j) == 1
        count += 1
      end
    elsif (j == @matrix_size - 1 && i != @matrix_size - 1) || i != @matrix_size - 1
      if get_elem(i, j - 1) == 1
        count += 1
      end
      if get_elem(i + 1, j - 1) == 1
        count += 1
      end
      if get_elem(i + 1, j) == 1
        count += 1
      end
      if get_elem(i + 1, 0) == 1
        count += 1
      end
      if get_elem(i, 0) == 1
        count += 1
      end
      if get_elem(i - 1, 0) == 1
        count += 1
      end
      if get_elem(i - 1, j) == 1
        count += 1
      end
      if get_elem(i - 1, j - 1) == 1
        count += 1
      end
    elsif (j == @matrix_size - 1 && i != @matrix_size - 1) || j != @matrix_size - 1
      if get_elem(i, j - 1) == 1
        count += 1
      end
      if get_elem(0, j - 1) == 1
        count += 1
      end
      if get_elem(0, j) == 1
        count += 1
      end
      if get_elem(0, j + 1) == 1
        count += 1
      end
      if get_elem(i, j + 1) == 1
        count += 1
      end
      if get_elem(i - 1, j + 1) == 1
        count += 1
      end
      if get_elem(i - 1, j) == 1
        count += 1
      end
      if get_elem(i - 1, j - 1) == 1
        count += 1
      end
    else
      if get_elem(i, j - 1) == 1
        count += 1
      end
      if get_elem(0, j - 1) == 1
        count += 1
      end
      if get_elem(0, j) == 1
        count += 1
      end
      if get_elem(0, 0) == 1
        count += 1
      end
      if get_elem(i, 0) == 1
        count += 1
      end
      if get_elem(i - 1, 0) == 1
        count += 1
      end
      if get_elem(i - 1, j) == 1
        count += 1
      end
      if get_elem(i - 1, j - 1) == 1
        count += 1
      end
    end

    #puts count
    count
  end
end