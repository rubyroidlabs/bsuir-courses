class Category < ActiveRecord::Base

  has_many :expenses, :dependent => :destroy
  belongs_to :user

end
