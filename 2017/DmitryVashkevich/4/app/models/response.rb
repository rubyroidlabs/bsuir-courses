# Response
class Response < ApplicationRecord
  validates :text, presence: true
  has_one :user, as: :person
  belongs_to :advert
end
