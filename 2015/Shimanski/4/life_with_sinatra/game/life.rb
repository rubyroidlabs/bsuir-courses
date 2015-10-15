class Life
  attr_reader :matrix_w, :matrix_h, :matrix
  attr_accessor :matrix
  def initialize(height = 10, weight = height)
    @matrix_h = height
    @matrix_w = weight
    @matrix = Array.new(height) do
      Array.new(weight).map! do
        rand < 0.5 ? 0 : 1
      end
    end
  end

  def create_clear_matrix(height, weight)
    matrix = Array.new(height) do
      Array.new(weight).map! do
        0
      end
    end
    matrix
  end

  def print_matrix
    system 'clear'
    0.upto(@matrix_h - 1) do |i|
      0.upto(@matrix_w - 1) do |j|
        print '*  ' if @matrix[i][j] == 1
        print '.  ' if @matrix[i][j] == 0
      end
      puts ''
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
    temp_matrix = create_clear_matrix(@matrix_h, @matrix_w)
    0.upto(@matrix_h - 1) do |i|
      0.upto(@matrix_w - 1) do |j|
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

  def get_count_of_alive(i, j)
    count = 0
    if i != @matrix_h - 1 && j != @matrix_w - 1
      count += 1 if get_elem(i - 1, j - 1) == 1
      count += 1 if get_elem(i - 1, j) == 1
      count += 1 if get_elem(i - 1, j + 1) == 1
      count += 1 if get_elem(i, j - 1) == 1
      count += 1 if get_elem(i, j + 1) == 1
      count += 1 if get_elem(i + 1, j - 1) == 1
      count += 1 if get_elem(i + 1, j + 1) == 1
      count += 1 if get_elem(i + 1, j) == 1
    elsif (j == @matrix_w - 1 && i != @matrix_h - 1) || i != @matrix_h - 1
      count += 1 if get_elem(i, j - 1) == 1
      count += 1 if get_elem(i + 1, j - 1) == 1
      count += 1 if get_elem(i + 1, j) == 1
      count += 1 if get_elem(i + 1, 0) == 1
      count += 1 if get_elem(i, 0) == 1
      count += 1 if get_elem(i - 1, 0) == 1
      count += 1 if get_elem(i - 1, j) == 1
      count += 1 if get_elem(i - 1, j - 1) == 1
    elsif (j == @matrix_w - 1 && i != @matrix_h - 1) || j != @matrix_w - 1
      count += 1 if get_elem(i, j - 1) == 1
      count += 1 if get_elem(0, j - 1) == 1
      count += 1 if get_elem(0, j) == 1
      count += 1 if get_elem(0, j + 1) == 1
      count += 1 if get_elem(i, j + 1) == 1
      count += 1 if get_elem(i - 1, j + 1) == 1
      count += 1 if get_elem(i - 1, j) == 1
      count += 1 if get_elem(i - 1, j - 1) == 1
    else
      count += 1 if get_elem(i, j - 1) == 1
      count += 1 if get_elem(0, j - 1) == 1
      count += 1 if get_elem(0, j) == 1
      count += 1 if get_elem(0, 0) == 1
      count += 1 if get_elem(i, 0) == 1
      count += 1 if get_elem(i - 1, 0) == 1
      count += 1 if get_elem(i - 1, j) == 1
      count += 1 if get_elem(i - 1, j - 1) == 1
    end
    count
  end
end
