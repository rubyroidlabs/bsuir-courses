class Version < Array
  def initialize s
    super(s.split('.').map { |e| e.to_s })
  end
  def < x
    (self <=> x) < 0
  end
  def > x
    (self <=> x) > 0
  end
  def >= x
    (self <=> x) >= 0
  end
  def <= x
    (self <=> x) <= 0
  end
  def == x
    (self <=> x) == 0
  end
  def to_s
    self.join('.')
  end
end
