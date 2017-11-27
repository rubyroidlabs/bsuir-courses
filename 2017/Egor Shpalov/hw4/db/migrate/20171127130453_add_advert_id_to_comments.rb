class AddAdvertIdToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :advert_id, :integer, null: false
    add_index :comments, :advert_id
  end
end
