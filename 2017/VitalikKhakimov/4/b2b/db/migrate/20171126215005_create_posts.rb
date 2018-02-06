class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :preview
      t.string :adt
      t.string :contacts

      t.timestamps
    end
  end
end
