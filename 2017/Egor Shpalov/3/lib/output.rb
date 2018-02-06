class Output
  def initialize(filename)
    @filename = filename
  end

  def save_data(list)
    CSV.open(@filename, 'wb') do |csv|
      list.each do |item|
        csv << item unless item.last.nil?
      end
    end
  end
end
