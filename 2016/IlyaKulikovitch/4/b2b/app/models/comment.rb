class Comment < ApplicationRecord
  validates :commenter, :msg, presence: true
  belongs_to :post
end
