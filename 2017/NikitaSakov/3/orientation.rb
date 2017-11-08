class Orientation
  FILE = 'status_list'.freeze
  def self.by_full_name(person)
    file = File.open(FILE)
    file.each do |line|
      if line.split('-').first == person
        file.close
        return line.split('-').last
      end
    end
  end

  def self.find_full_name(surname)
    file = File.open(FILE)
    file.each do |line|
      if line.include? surname
        file.close
        return line.split('-').first
      end
    end
  end
end
