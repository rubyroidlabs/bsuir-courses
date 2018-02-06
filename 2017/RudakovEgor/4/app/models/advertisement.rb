class Advertisement < ApplicationRecord
  has_many :comments, dependent: :destroy
end
