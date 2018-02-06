class CreateSellPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :sell_posts do |t|
      t.string :title
      t.text :body
      t.string :phone
      t.string :name
      t.integer :sell_currency

      t.timestamps
    end
  end
end
