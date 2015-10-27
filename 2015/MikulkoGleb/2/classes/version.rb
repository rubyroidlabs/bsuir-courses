class Version < Array
  def initialize(s)
    super(s.split('.').map(&:to_s))
  end

  def <(x)
    (self <=> x) < 0
  end

  def >(x)
    (self <=> x) > 0
  end

  def >=(x)
    (self <=> x) >= 0
  end

  def <=(x)
    (self <=> x) <= 0
  end

  def ==(x)
    (self <=> x) == 0
  end

  def to_s
    join('.')
  end
end
