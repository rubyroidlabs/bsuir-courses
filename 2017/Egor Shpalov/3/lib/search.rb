class Search
  attr_accessor :str_data, :str_user
  attr_reader :variant

  def distance
    range_border_init
    current_row = current_row_init
    1.upto(@len_user) do |i|
      previous_row = current_row
      current_row  = [i] + [0] * @len_data
      1.upto(@len_data) do |j|
        current_row[j] = changes(current_row, previous_row, j, i)
      end
    end
    current_row[@len_data]
  end

  private

  def range_border_init
    @len_data = @str_data.length
    @len_user = @str_user.length
    @variant  = @str_data
    return unless @len_data > @len_user
    @str_data, @str_user = @str_user, @str_data
    @len_data, @len_user = @len_user, @len_data
  end

  def current_row_init
    current_row = []
    0.upto(@len_data) { |i| current_row << i }
    current_row
  end

  def changes(current_row, previous_row, j, i)
    add    = previous_row[j] + 1
    delete = current_row[j - 1] + 1
    change = previous_row[j - 1]
    change += 1 if @str_data[j - 1] != @str_user[i - 1]
    [add, delete, change].min
  end
end

search = Search.new
search.str_data = 'Search'
search.str_user = 'SeeearVh'
p search.distance
p search.variant
