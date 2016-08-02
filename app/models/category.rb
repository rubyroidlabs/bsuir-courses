class Category < ActiveRecord::Base

  include Quantifiable::InstanceMethods

  has_many :expenses, :dependent => :destroy
  belongs_to :user

end
