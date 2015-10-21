class HandleInput
  def initialize
  	begin
      raise 'Не введено название гема' if ARGV.empty?
      raise 'Не введены параметры для поиска' unless ARGV[1]
      @name = ARGV[0]
      @param = ARGV[1..-1]
      self.CheckFormatVersion
    rescue Exception => e
      print e.message
	  end
  end

  def CheckFormatVersion
    @param.each do |vers|
      unless /\A(>=|>|<|<=|~>) ([0-9]+\.)*[0-9]+\Z/ === vers.to_s
        raise 'Неверный формат версии'
      end
    end
  end

  def name
    @name
  end

  def param
    @param
  end
end
