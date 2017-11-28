class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.text :cotacts
      t.integer :exchange

      t.timestamps
    end
  end
end
