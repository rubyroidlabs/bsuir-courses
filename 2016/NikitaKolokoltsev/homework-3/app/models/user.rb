# User
class User < ActiveRecord::Base
  has_secure_password

  has_many :quotes, dependent: :destroy
  has_many :words, dependent: :destroy

  validates_uniqueness_of :email
end
