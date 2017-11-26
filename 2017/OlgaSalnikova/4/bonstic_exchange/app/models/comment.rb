class Comment < ApplicationRecord
  belongs_to :poster
  validates :comment, presence: true,
            length: {minimum: 10, maximum: 255}
end

