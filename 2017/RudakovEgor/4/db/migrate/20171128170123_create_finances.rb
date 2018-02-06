class CreateFinances < ActiveRecord::Migration[5.1]
  def change
    create_table :finances do |t|
      t.string :bitcoin
      t.string :bonstick

      t.timestamps
    end
  end
end
