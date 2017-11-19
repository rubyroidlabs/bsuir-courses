class Celebrity
  attr_accessor :celebrity

  def initialize(name, orientation, info)
    @celebrity = { 'name' => name, 'orientation' => orientation,
                   'info' => info }
  end
end
