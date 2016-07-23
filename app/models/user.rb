class User < ActiveRecord::Base

  has_secure_password

  has_many :categories, :dependent => :destroy
  has_many :expenses

  def categories_sort_by_name
    self.categories.all.sort_by {|hash| hash[:name]}
  end

end
