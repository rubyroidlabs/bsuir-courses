class InputParse
  def initialize(x)
    @args = x
  end

  def parse
    @opts = {}
    @args.each_index do |i|
      add(@args[i]) if i != 0
    end
    @opts
  end

  def getName
    @args[0]
  end

  def add(x)
    if x.include?('>= ')
      add_greatorequal(x)
    elsif x.include?('<= ')
      add_loworequal(x)
    elsif x.include?('~> ')
      add_sp(x)
    elsif x.include?('> ')
      add_great(x)
    elsif x.include?('< ')
      add_low(x)
    elsif @opts.has_key?(:equal)
      fail
    else
      @opts[:equal] = x
    end
  rescue
    puts 'Error, two equating'
    Kernel.abort
  end

  def add_greatorequal(x)
    if @opts.has_key?(:greatorequal)
      if x.delete('>= ') > @opts[:greatorequal]
        @opts[:greatorequal] = x.delete('>= ')
      end
    else
      @opts[:greatorequal] = x.delete('>= ')
    end
  end

  def add_loworequal(x)
    if @opts.has_key?(:loworequal)
      if x.delete('<= ') < @opts[:loworequal]
        @opts[:loworequal] = x.delete('<= ')
      end
    else
      @opts[:loworequal] = x.delete('<= ')
    end
  end

  def add_sp(x)
    add_greatorequal('>=' + x.delete('~>'))
    temp_array = x.delete('~> ').split('.')
    if temp_array.size > 1
      temp_array[-1] = '0'
      temp_char = temp_array[-2].to_i
      temp_char += 1
      temp_array[-2] = temp_char.to_s
    else
      temp_char = temp_array[-1].to_i
      temp_char += 1
      temp_array[-1] = temp_char.to_s
    end
    add('< ' + temp_array.join('.'))
  end

  def add_great(x)
    if @opts.has_key?(:great)
      @opts[:great] = x.delete('> ') if x.delete('> ') > @opts[:great]
    else
      @opts[:great] = x.delete('> ')
    end
  end

  def add_low(x)
    if @opts.has_key?(:low)
      @opts[:low] = x.delete('< ') if x.delete('< ') < @opts[:low]
    else
      @opts[:low] = x.delete('< ')
    end
  end
end
