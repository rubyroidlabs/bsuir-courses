class Category < ActiveRecord::Base

  include Quantifiable::InstanceMethods

  has_many :expenses, :dependent => :destroy
  belongs_to :user

  def expenses_sort_by_date
    self.expenses.sort_by {|expense| expense[:date]}.reverse
  end

end
