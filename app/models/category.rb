class Category < ActiveRecord::Base

  has_many :expenses, :dependent => :destroy
  belongs_to :user

  def expenses_sort_by_date
    self.expenses.sort_by {|expense| expense[:date]}.reverse
  end

  def total_amount
    self.expenses.collect {|eexpense| eexpense.amount}.sum
  end

end
