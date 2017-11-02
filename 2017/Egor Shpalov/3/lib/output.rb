class Output
  def initialize(filename)
    @filename = filename
  end

  def save_data(list)
    CSV.open(@filename, 'wb') do |csv|
      csv << %w[NAME DESCRIPTION]
      list.each { |item| csv << item }
    end
    puts 'Data was successfully saved...'
  end
end
