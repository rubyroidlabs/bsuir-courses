class Parser

  attr_reader :gem_name, :version_specifier

  def initialize(arguments)
    @gem_name, @version_specifier = arguments
    if @gem_name.match(/\w+/).to_s != @gem_name
      raise ArgumentError
    end
    if @version_specifier.match(/[!=><~]{1,2}\s*(\d+\.)*\d+/).to_s != @version_specifier
      raise ArgumentError
    end
  end

end


