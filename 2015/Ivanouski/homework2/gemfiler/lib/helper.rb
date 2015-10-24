class Helper
  def self.connection_error(err)
    print "CONNECTION ERROR!\n#{err}\n"
    exit 1
  end

  def self.input_error(err)
    print "ERROR: Check your input!\n#{err}\n"
    exit 1
  end
end
