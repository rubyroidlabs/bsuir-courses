require './models/lab'

class Subject
  attr_accessor :hash_of_labs
  def initialize
    @hash_of_labs = {}
  end
end


