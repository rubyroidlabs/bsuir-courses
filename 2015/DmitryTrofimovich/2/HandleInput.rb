class HandleInput
  def initialize
    @name = ARGV[0]
    @param = ARGV[1..-1]
    raise 'Не введено название гема' if ARGV.empty?
    raise 'Не введены параметры для поиска' unless ARGV[1]
    check_format_version
    rescue Exception => e
      print e.message
  end

  def check_format_version
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
