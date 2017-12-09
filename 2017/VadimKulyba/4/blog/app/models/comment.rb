# Comment model for article
class Comment < ApplicationRecord
  belongs_to :article
  validates :commenter, presence: true,
                        length: { minimum: 2 }
end
