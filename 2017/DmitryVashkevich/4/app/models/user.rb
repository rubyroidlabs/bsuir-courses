# User
class User < ApplicationRecord
  validates :name, :phone, presence: true
  belongs_to :person, polymorphic: true
end
