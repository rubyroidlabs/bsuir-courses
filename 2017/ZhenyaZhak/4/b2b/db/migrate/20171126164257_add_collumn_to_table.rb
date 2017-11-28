class AddCollumnToTable < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :station, :string
    add_column :articles, :count, :integer
  end
end
