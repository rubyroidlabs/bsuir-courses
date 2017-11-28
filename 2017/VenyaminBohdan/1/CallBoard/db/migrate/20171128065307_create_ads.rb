class CreateAds < ActiveRecord::Migration[5.1]
  def change
    create_table :ads do |t|
      t.string :title
      t.text :description
      t.string :contact

      t.timestamps
    end
  end
end
