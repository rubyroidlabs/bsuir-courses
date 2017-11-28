class AddTradeToAdverts < ActiveRecord::Migration[5.1]
  def change
    add_column :adverts, :trade, :string
  end
end
