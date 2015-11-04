# Hadle review data
class Handler
  attr_accessor :group, :lectors, :comments, :keywords

  def initialize(group_number)
    @group = group_number
    @lectors ||= []
    @comments ||= []
  end

  def handle
    lookuper = LookUper.new(@group)
    @lectors = lookuper.seek_lectors
    printer = Printer.new
    lectors.each do |lector|
      printer.print_lector(lector)
      LookUper.new(@group).seek_reviews(lector)
    end
  end
end
