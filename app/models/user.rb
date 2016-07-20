class User < ActiveRecord::Base

  has_secure_password

  has_many :categories, :dependent => :destroy
  has_many :expenses

end
