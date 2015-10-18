class InputParse
  def initialize(x)
    @args = x
  end

  def parse
    @opts = {}
    @args.each_index do |i|
      self.add(@args[i]) if i != 0
    end
    @opts
  end

  def getName()
    @args[0]
  end

  def add (x)
    if (x.include?(">= "))
      if (@opts.has_key?(:greatorequal))
        if (x.delete(">= ") > @opts[:greatorequal])
          @opts[:greatorequal] = x.delete(">= ")
        end
      else
        @opts[:greatorequal] = x.delete(">= ")
      end
      return
    end

    if (x.include?("<= "))
      if (@opts.has_key?(:loworequal))
        if (x.delete("<= ") < @opts[:loworequal])
          @opts[:loworequal] = x.delete("<= ")
        end
      else
        @opts[:loworequal] = x.delete("<= ")
      end
      return
    end

    if (x.include?("~> "))
      self.add(">=" + x.delete("~>"))
      temp_array = x.delete("~> ").split(".")
      if (temp_array.size > 1)
        temp_array[-1] = "0"
        temp_char = temp_array[-2].to_i
        temp_char += 1
        temp_array[-2] = temp_char.to_s
      else
        temp_char = temp_array[-1].to_i
        temp_char += 1
        temp_array[-1] = temp_char.to_s
      end
      self.add("< " + temp_array.join("."))
      return 
    end

    if (x.include?("> "))
      if (@opts.has_key?(:great))
        if (x.delete("> ") > @opts[:great])
          @opts[:great] = x.delete("> ")
        end
      else
        @opts[:great] = x.delete("> ")
      end
      return
    end

    if (x.include?("< "))
      if (@opts.has_key?(:low))
        if (x.delete("< ") < @opts[:low])
          @opts[:low] = x.delete("< ")
        end
      else
        @opts[:low] = x.delete("< ")
      end
      return
    end

    if(@opts.has_key?(:equal))
      raise
    else
      @opts[:equal] = x
    end
  rescue
    puts "Error, two equating"
    Kernel.abort
  end
end
