class Category < ActiveRecord::Base

  has_many :expenses, :dependent => :destroy
  belongs_to :user

  def expenses_sort_by_date
    self.expenses.sort_by {|hash| hash[:date]}.reverse
  end

end
