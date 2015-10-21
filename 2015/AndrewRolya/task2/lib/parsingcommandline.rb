class ParsingCommandLine
  def initialize(argv, hash_map)
    @p_argv = argv
    @p_hash_map = hash_map
  end
  def parsing_command_line
    1.upto(2) do |i|
      if @p_argv[i] != nil
        key = /[\=\>\<\!\~]+/.match(@p_argv[i]).to_s
        value = Gem::Version.new(/[\w.]+/.match(@p_argv[i]).to_s)
        case key
        when "~>"
          @p_hash_map[">="] = value
          @p_hash_map["<"] = value.bump
        else
          @p_hash_map[key] = value
        end
      end
    end
    return @p_hash_map
  end
end
