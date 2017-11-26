# CreateAdverts
class CreateAdverts < ActiveRecord::Migration[5.1]
  def change
    create_table :adverts do |t|
      t.string :tittle
      t.string :description
      t.string :currency
      t.integer :count
      t.timestamps
    end
  end
end
