class AddKindItemToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :kind, :string
    add_column :posts, :item, :string
  end
end
