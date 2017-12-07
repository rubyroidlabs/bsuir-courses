class CreateB2Bs < ActiveRecord::Migration[5.1]
  def change
    create_table :b2_bs do |t|
      t.string :title
      t.text :body
      t.string :phone
      t.string :name
      t.integer :sell_currency

      t.timestamps
    end
  end
end
