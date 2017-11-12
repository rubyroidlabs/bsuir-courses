module CheckCelebrity
  FILE_NAME = 'database.txt'.freeze

  def self.lgbt?(name)
    File.open(FILE_NAME, 'r') do |file|
      while line = file.gets
        return 1 if line.strip.eql? name
      end
      nil
    end
  end
end
