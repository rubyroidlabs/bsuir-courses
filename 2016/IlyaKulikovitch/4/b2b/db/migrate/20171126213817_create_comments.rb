class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :msg
      t.references :post

      t.timestamps
      #add_index :comments, :post_id
    end
  end
end
