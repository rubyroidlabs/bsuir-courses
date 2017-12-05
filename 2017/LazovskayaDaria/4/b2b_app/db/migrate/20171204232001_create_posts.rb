class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :text
      t.string :contact

      t.timestamps
    end
  end
end
