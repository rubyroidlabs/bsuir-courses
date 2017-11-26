# Advert
class Advert < ApplicationRecord
  validates :tittle, :currency, :count, presence: true
  has_one :user, as: :person
  has_many :responses
end
