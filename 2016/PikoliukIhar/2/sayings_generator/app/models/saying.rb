class Saying < ApplicationRecord
  has_many :words, dependent: :destroy
end
