class SearchByName
  FILE = 'orient_status.out'.freeze

  def self.orient_by_name(fullname)
    status_file = File.open(FILE)
    status_file.each do |name|
      if name.split('-').first == fullname
        status_file.close
        return name.split('-').last
      end
    end
  end

  def self.full_name_by_part(lastname)
    status_file = File.open(FILE)
    status_file.each do |name|
      if name.include? lastname
        status_file.close
        return name.split('-').first
      end
    end
  end
end
