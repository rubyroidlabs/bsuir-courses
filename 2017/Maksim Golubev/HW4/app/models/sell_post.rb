class SellPost < ApplicationRecord
  validates :title, :body, :phone, :name, :sell_currency, presence: true
  enum sell_currency: { bitcoin: 0, bonstick: 1 }
end
